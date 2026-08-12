# IELTS 数据同步：先拉后推，一条命令搞定
Set-Location $PSScriptRoot

git pull --rebase --autostash

$dirty = git status --porcelain
if ($dirty) {
  git add -A
  git commit -m "practice: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
  git push
  Write-Output "✓ 已同步（有新数据推送）"
} else {
  git push 2>$null
  Write-Output "✓ 已同步（无新数据）"
}
