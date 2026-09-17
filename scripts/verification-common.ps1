# Shared, fail-closed checks used by verification and packaging.
$jsp637ExpectedDeclarations = @(
  'Jsp637.first_question', 'Jsp637.second_question', 'Jsp637.third_question',
  'Jsp637.jsp_000637', 'Erdos777.erdos_777'
)
$jsp637AllowedAxioms = @('propext', 'Classical.choice', 'Quot.sound')
$jsp637RequiredChecks = [ordered]@{
  'lake build' = 'artifacts/lake-build.log'
  'lake env lean Audit.lean' = 'artifacts/axioms.log'
  'lake env leanchecker --verbose ErdosProblems.Erdos777' = 'artifacts/kernel-upstream.log'
  'lake env leanchecker --verbose Jsp637' = 'artifacts/kernel-entry.log'
}

function Get-Jsp637Sha256([string]$Path) {
  (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Get-Jsp637InputHashes {
  $jsp637Paths = @(
    Get-ChildItem -LiteralPath . -File -Filter '*.lean' | ForEach-Object { $_.Name }
    Get-ChildItem -LiteralPath vendor -File -Filter '*.lean' -Recurse | ForEach-Object {
      $_.FullName.Substring($jsp637Root.Length + 1).Replace([char]92, [char]47)
    }
    Get-ChildItem -LiteralPath scripts -File -Filter '*.ps1' | ForEach-Object { 'scripts/' + $_.Name }
    'lean-toolchain'
    'lakefile.toml'
    'lake-manifest.json'
  ) | Sort-Object -Unique
  foreach ($jsp637Path in $jsp637Paths) {
    [ordered]@{
      path = $jsp637Path
      sha256 = Get-Jsp637Sha256 $jsp637Path
      bytes = (Get-Item -LiteralPath $jsp637Path).Length
    }
  }
}

function Assert-Jsp637InputHashes($Expected) {
  $jsp637Current = @(Get-Jsp637InputHashes)
  if (@($Expected).Count -ne $jsp637Current.Count) {
    throw 'Verification inputs changed; run scripts/verify.ps1 again.'
  }
  foreach ($jsp637Input in $jsp637Current) {
    $jsp637Recorded = @($Expected | Where-Object { $_.path -ceq $jsp637Input.path })
    if ($jsp637Recorded.Count -ne 1 -or
        $jsp637Recorded[0].sha256 -cne $jsp637Input.sha256 -or
        $jsp637Recorded[0].bytes -ne $jsp637Input.bytes) {
      throw "Verification input changed: $($jsp637Input.path); run scripts/verify.ps1 again."
    }
  }
}

function Assert-Jsp637SourceScan {
  $jsp637ProofPaths = @(Get-Jsp637InputHashes | Where-Object { $_.path.EndsWith('.lean') } | ForEach-Object { $_.path })
  $jsp637Forbidden = Select-String -LiteralPath $jsp637ProofPaths -Pattern '\b(sorry|admit|axiom|unsafe|native_decide)\b|sorryAx|Lean\.ofReduceBool|Lean\.trustCompiler'
  if ($jsp637Forbidden) {
    $jsp637First = $jsp637Forbidden | Select-Object -First 1
    throw "Unapproved proof mechanism at $($jsp637First.Path):$($jsp637First.LineNumber)."
  }
}

function Assert-Jsp637AxiomAudit {
  $jsp637Lines = @(Get-Content -LiteralPath artifacts/axioms.log | Where-Object { $_ -match 'depends on axioms:|does not depend on any axioms' })
  if ($jsp637Lines.Count -ne $jsp637ExpectedDeclarations.Count) {
    throw 'Expected exactly five audited declarations in artifacts/axioms.log.'
  }
  $jsp637Seen = @()
  foreach ($jsp637Line in $jsp637Lines) {
    if ($jsp637Line -match "^'([^']+)' depends on axioms: \[(.*)\]$") {
      $jsp637Declaration = $Matches[1]
      $jsp637Axioms = @($Matches[2] -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ })
    } elseif ($jsp637Line -match "^'([^']+)' does not depend on any axioms$") {
      $jsp637Declaration = $Matches[1]
      $jsp637Axioms = @()
    } else {
      throw "Unrecognized axiom audit output: $jsp637Line"
    }
    if ($jsp637Declaration -cnotin $jsp637ExpectedDeclarations -or $jsp637Declaration -cin $jsp637Seen) {
      throw "Unexpected or duplicate audited declaration: $jsp637Declaration"
    }
    foreach ($jsp637Axiom in $jsp637Axioms) {
      if ($jsp637Axiom -cnotin $jsp637AllowedAxioms) {
        throw "Unapproved axiom for $($jsp637Declaration): $jsp637Axiom"
      }
    }
    $jsp637Seen += $jsp637Declaration
  }
}

function Get-Jsp637DependencyRevisions {
  $jsp637Manifest = Get-Content -LiteralPath lake-manifest.json -Raw | ConvertFrom-Json
  foreach ($jsp637Package in $jsp637Manifest.packages) {
    if ($jsp637Package.type -ne 'git' -or $jsp637Package.rev -notmatch '^[0-9a-f]{40}$') {
      throw "Dependency is not pinned to a full Git commit: $($jsp637Package.name)."
    }
    $jsp637PackagePath = Join-Path $jsp637Manifest.packagesDir $jsp637Package.name
    $jsp637Head = & git -C $jsp637PackagePath rev-parse HEAD 2>$null
    if ($LASTEXITCODE -ne 0 -or $jsp637Head -cne $jsp637Package.rev) {
      throw "Dependency checkout differs from manifest: $($jsp637Package.name)."
    }
    $jsp637Dirty = @(& git -C $jsp637PackagePath status --porcelain --untracked-files=all)
    if ($LASTEXITCODE -ne 0 -or $jsp637Dirty.Count -ne 0) {
      throw "Dependency checkout is not clean: $($jsp637Package.name)."
    }
    [ordered]@{ name = $jsp637Package.name; rev = $jsp637Head; clean = $true }
  }
}

function Assert-Jsp637Verification {
  $jsp637Evidence = Get-Content -LiteralPath artifacts/verification.json -Raw | ConvertFrom-Json
  if ($jsp637Evidence.schema_version -ne 2 -or $jsp637Evidence.status -cne 'passed') {
    throw 'No successful current verification record; run scripts/verify.ps1.'
  }
  Assert-Jsp637InputHashes $jsp637Evidence.verified_inputs
  Assert-Jsp637SourceScan
  Assert-Jsp637AxiomAudit
  foreach ($jsp637Command in $jsp637RequiredChecks.Keys) {
    $jsp637Check = @($jsp637Evidence.checks | Where-Object { $_.command -ceq $jsp637Command })
    if ($jsp637Check.Count -ne 1 -or $jsp637Check[0].exit_code -ne 0 -or
        $jsp637Check[0].log -cne $jsp637RequiredChecks[$jsp637Command]) {
      throw "Missing successful verification command: $jsp637Command"
    }
    if ((Get-Jsp637Sha256 $jsp637Check[0].log) -cne $jsp637Check[0].log_sha256) {
      throw "Verification log changed: $($jsp637Check[0].log)"
    }
  }
  $jsp637Dependencies = @(Get-Jsp637DependencyRevisions)
  if ($jsp637Dependencies.Count -ne @($jsp637Evidence.dependency_revisions).Count) {
    throw 'Dependency evidence does not match the current manifest.'
  }
  foreach ($jsp637Dependency in $jsp637Dependencies) {
    $jsp637Recorded = @($jsp637Evidence.dependency_revisions | Where-Object { $_.name -ceq $jsp637Dependency.name })
    if ($jsp637Recorded.Count -ne 1 -or $jsp637Recorded[0].rev -cne $jsp637Dependency.rev -or -not $jsp637Recorded[0].clean) {
      throw "Dependency evidence mismatch: $($jsp637Dependency.name)."
    }
  }
}

