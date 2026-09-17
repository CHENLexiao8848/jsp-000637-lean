param([switch]$FetchCache)
$ErrorActionPreference = "Stop"
$jspRoot = Split-Path -Parent $PSScriptRoot
Push-Location -LiteralPath $jspRoot
try {
  New-Item -ItemType Directory -Force evidence | Out-Null
  $jspPaths = @("JSPProofs/JSP001018.lean","JSPProofs.lean","Audit.lean","lean-toolchain","lakefile.toml","lake-manifest.json","scripts/verify.ps1")
  $jspHashes = @($jspPaths | ForEach-Object { [ordered]@{path=$_;sha256=(Get-FileHash -LiteralPath $_ -Algorithm SHA256).Hash.ToLowerInvariant()} })
  $jspChecks = [Collections.Generic.List[object]]::new()
  $jspRecord = [ordered]@{status="running";started_utc=[DateTime]::UtcNow.ToString("o");theorem="JSP001018.erdos1213_int";lean_version="4.34.0";mathlib_commit="5ed2965256430c3649e86755f9576b54eca72435";allowed_axioms=@("propext","Classical.choice","Quot.sound");source_hashes=$jspHashes;checks=@();replay_scope="JSPProofs.JSP001018 only, using pinned imported dependencies and the same Lean kernel"}
  function Save-Record {
    $jspRecord.checks = @($jspChecks.ToArray())
    $jspRecord | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath evidence/verification.json -Encoding utf8
  }
  function Invoke-Check([string[]]$LakeArgs,[string]$Log) {
    $jspStart = [DateTime]::UtcNow.ToString("o")
    & lake @LakeArgs *> $Log
    $jspExit = $LASTEXITCODE
    $jspText = [IO.File]::ReadAllText((Join-Path $jspRoot $Log))
    $jspText = $jspText.Replace($jspRoot,"<package>").Replace($jspRoot.Replace([char]92,[char]47),"<package>")
    [IO.File]::WriteAllText((Join-Path $jspRoot $Log),$jspText.Replace("`r`n","`n"),[Text.UTF8Encoding]::new($false))
    $jspChecks.Add([ordered]@{command="lake "+($LakeArgs -join " ");exit_code=$jspExit;started_utc=$jspStart;ended_utc=[DateTime]::UtcNow.ToString("o");log=$Log;sha256=(Get-FileHash -LiteralPath $Log -Algorithm SHA256).Hash.ToLowerInvariant()})
    Save-Record
    if ($jspExit -ne 0) { throw ("Check failed; see "+$Log) }
    Write-Output ("Passed: lake "+($LakeArgs -join " "))
  }
  Save-Record
  try {
    if ($FetchCache) { Invoke-Check @("exe","cache","get") "evidence/cache.log" }
    Invoke-Check @("build") "evidence/build.log"
    Invoke-Check @("env","lean","Audit.lean") "evidence/axioms.log"
    $jspAudit = Get-Content -LiteralPath evidence/axioms.log -Raw
    foreach ($jspName in @("JSP001018.erdos1213_int","JSP001018.erdos1213","JSP001018.bounded_gap_equal_intervals")) {
      $jspMatch = [regex]::Match($jspAudit,[regex]::Escape($jspName)+". depends on axioms: \[([^\]]*)\]")
      if (-not $jspMatch.Success) { throw ("Missing axiom audit: "+$jspName) }
      foreach ($jspAxiom in ($jspMatch.Groups[1].Value.Split(",") | ForEach-Object {$_.Trim()})) {
        if ($jspAxiom -notin $jspRecord.allowed_axioms) { throw ("Unexpected axiom: "+$jspAxiom) }
      }
    }
    Invoke-Check @("env","leanchecker","--verbose","JSPProofs.JSP001018") "evidence/kernel-replay.log"
    foreach ($jspInput in $jspHashes) {
      if ((Get-FileHash -LiteralPath $jspInput.path -Algorithm SHA256).Hash.ToLowerInvariant() -ne $jspInput.sha256) { throw ("Input changed: "+$jspInput.path) }
    }
    $jspRecord.status="passed"
    $jspRecord.completed_utc=[DateTime]::UtcNow.ToString("o")
    Save-Record
  } catch {
    $jspRecord.status="failed"
    Save-Record
    throw
  }
} finally { Pop-Location }
