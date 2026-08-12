$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
Set-Location $PSScriptRoot

function Invoke-Git {
  param([string[]]$GitArgs)
  & git @GitArgs
  if ($LASTEXITCODE -ne 0) {
    throw "git $($GitArgs -join ' ') failed with exit code $LASTEXITCODE"
  }
}

Invoke-Git -GitArgs @('pull', '--rebase', '--autostash')

$dirty = & git status --porcelain
if ($LASTEXITCODE -ne 0) {
  throw "git status failed with exit code $LASTEXITCODE"
}

if ($dirty) {
  Invoke-Git -GitArgs @('add', '-A')
  Invoke-Git -GitArgs @('commit', '-m', "practice: $(Get-Date -Format 'yyyy-MM-dd HH:mm')")
  Invoke-Git -GitArgs @('push')
  Write-Output 'Sync complete: new data pushed.'
} else {
  Invoke-Git -GitArgs @('push')
  Write-Output 'Sync complete: no new data.'
}
