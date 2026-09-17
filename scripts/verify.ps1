param([switch]$FetchCache)
$ErrorActionPreference = 'Stop'
$jsp637Root = Split-Path -Parent $PSScriptRoot
Push-Location -LiteralPath $jsp637Root
try {
  New-Item -ItemType Directory -Force -Path artifacts | Out-Null
  $jsp637Checks = [Collections.Generic.List[object]]::new()
  $jsp637InputPaths = @('Jsp637.lean','vendor/plby/ErdosProblems/Erdos777.lean','Audit.lean','lean-toolchain','lakefile.toml','lake-manifest.json','scripts/verify.ps1')
  $jsp637Hashes = @($jsp637InputPaths | ForEach-Object { [ordered]@{path=$_;sha256=(Get-FileHash -LiteralPath $_ -Algorithm SHA256).Hash.ToLowerInvariant()} })
  $jsp637Record = [ordered]@{status='running';started_utc=[DateTime]::UtcNow.ToString('o');theorem='Jsp637.jsp_000637';lean_version='4.34.0';mathlib_commit='5ed2965256430c3649e86755f9576b54eca72435';checks=@();source_hashes=$jsp637Hashes;allowed_axioms=@('propext','Classical.choice','Quot.sound');replay_scope='Both local proof modules; imported Mathlib, not a fresh replay of all Mathlib';attribution='Apache-2.0 reuse, compatibility port and reproduction; no first-formalization claim'}
  function Save-Record {
    $jsp637Record.checks = @($jsp637Checks.ToArray())
    $jsp637Record | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath artifacts/verification.json -Encoding utf8
  }
  function Invoke-Checked([string[]]$LakeArgs, [string]$Log) {
    $jsp637Start = [DateTime]::UtcNow.ToString('o')
    & lake @LakeArgs *> $Log
    $jsp637Exit = $LASTEXITCODE
    $jsp637Exit | Set-Content -LiteralPath ($Log+'.exitcode') -Encoding ascii
    $jsp637Checks.Add([ordered]@{command='lake '+($LakeArgs -join ' ');exit_code=$jsp637Exit;started_utc=$jsp637Start;ended_utc=[DateTime]::UtcNow.ToString('o');log=$Log})
    Save-Record
    if ($jsp637Exit -ne 0) { throw ('Failed: lake '+($LakeArgs -join ' ')+'; see '+$Log) }
    Write-Output ('Passed: lake '+($LakeArgs -join ' '))
  }
  Save-Record
  try {
    if ($FetchCache) { Invoke-Checked @('exe','cache','get') 'artifacts/cache.log' }
    Invoke-Checked @('build') 'artifacts/lake-build.log'
    Invoke-Checked @('env','lean','Audit.lean') 'artifacts/axioms.log'
    $jsp637AxiomText = Get-Content -LiteralPath artifacts/axioms.log -Raw
    $jsp637Expected = @('Jsp637.first_question','Jsp637.second_question','Jsp637.third_question','Jsp637.jsp_000637','Erdos777.erdos_777')
    foreach ($jsp637Name in $jsp637Expected) {
      $jsp637Pattern = [regex]::Escape($jsp637Name) + "' depends on axioms: \[([^\]]*)\]"
      $jsp637Match = [regex]::Match($jsp637AxiomText,$jsp637Pattern)
      if (-not $jsp637Match.Success) { throw ('Missing axiom audit: '+$jsp637Name) }
      $jsp637Used = @($jsp637Match.Groups[1].Value.Split(',') | ForEach-Object { $_.Trim() })
      foreach ($jsp637Axiom in $jsp637Used) { if ($jsp637Axiom -notin $jsp637Record.allowed_axioms) { throw ('Unexpected axiom: '+$jsp637Axiom) } }
    }
    Invoke-Checked @('env','leanchecker','--verbose','ErdosProblems.Erdos777') 'artifacts/kernel-upstream.log'
    Invoke-Checked @('env','leanchecker','--verbose','Jsp637') 'artifacts/kernel-entry.log'
    foreach ($jsp637Item in $jsp637Hashes) { if ((Get-FileHash -LiteralPath $jsp637Item.path -Algorithm SHA256).Hash.ToLowerInvariant() -ne $jsp637Item.sha256) { throw ('Source changed during verification: '+$jsp637Item.path) } }
    Get-Content -LiteralPath artifacts/kernel-upstream.log,artifacts/kernel-entry.log | Set-Content -LiteralPath artifacts/kernel-replay.log -Encoding utf8
    $jsp637Hashes | ConvertTo-Json -Depth 3 | Set-Content -LiteralPath artifacts/source-hashes.json -Encoding utf8
    $jsp637Record.status='passed'
    $jsp637Record.completed_utc=[DateTime]::UtcNow.ToString('o')
    Save-Record
  } catch {
    $jsp637Record.status='failed'
    Save-Record
    throw
  }
} finally { Pop-Location }
