$ErrorActionPreference = 'Stop'
$jsp637Root = Split-Path -Parent $PSScriptRoot
Push-Location -LiteralPath $jsp637Root
try {
  $jsp637Record = Get-Content -LiteralPath artifacts/verification.json -Raw | ConvertFrom-Json
  if ($jsp637Record.status -ne 'passed') { throw 'Run verify.ps1 successfully before packaging' }
  foreach ($jsp637Required in @('lake build','lake env lean Audit.lean','lake env leanchecker --verbose ErdosProblems.Erdos777','lake env leanchecker --verbose Jsp637')) {
    $jsp637Check = @($jsp637Record.checks | Where-Object { $_.command -ceq $jsp637Required })
    if ($jsp637Check.Count -ne 1 -or $jsp637Check[0].exit_code -ne 0) { throw ('Missing successful check: '+$jsp637Required) }
  }
  foreach ($jsp637Item in $jsp637Record.source_hashes) {
    if ((Get-FileHash -LiteralPath $jsp637Item.path -Algorithm SHA256).Hash.ToLowerInvariant() -ne $jsp637Item.sha256) { throw ('Unverified source change: '+$jsp637Item.path) }
  }
  New-Item -ItemType Directory -Force -Path dist | Out-Null
  $jsp637Stage = Join-Path 'dist' ('package-'+[Guid]::NewGuid().ToString('N'))
  New-Item -ItemType Directory -Path $jsp637Stage | Out-Null
  $jsp637Inputs = @('Jsp637.lean','Audit.lean','lean-toolchain','lakefile.toml','lake-manifest.json','README.md','LICENSE','vendor','docs','scripts','.github','.gitignore','.gitattributes')
  foreach ($jsp637Path in $jsp637Inputs) { Copy-Item -LiteralPath $jsp637Path -Destination $jsp637Stage -Recurse }
  New-Item -ItemType Directory -Path (Join-Path $jsp637Stage 'artifacts') | Out-Null
  $jsp637Evidence = @('verification.json','source-hashes.json','axioms.log','lake-build.log','kernel-upstream.log','kernel-entry.log','kernel-replay.log','port.diff','provenance-check.json')
  foreach ($jsp637Path in $jsp637Evidence) { Copy-Item -LiteralPath (Join-Path 'artifacts' $jsp637Path) -Destination (Join-Path $jsp637Stage 'artifacts') }
  Compress-Archive -Path (Join-Path $jsp637Stage '*') -DestinationPath dist/JSP-000637-Lean.zip -Force
  $jsp637Hash = (Get-FileHash -LiteralPath dist/JSP-000637-Lean.zip -Algorithm SHA256).Hash.ToLowerInvariant()
  ($jsp637Hash+'  JSP-000637-Lean.zip') | Set-Content -LiteralPath dist/SHA256SUMS.txt -Encoding ascii
  Write-Output 'Verified-source archive: dist/JSP-000637-Lean.zip'
} finally { Pop-Location }
