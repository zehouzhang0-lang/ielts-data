#!/usr/bin/env bash
# IELTS 数据同步：先拉后推，一条命令搞定
set -e
cd "$(dirname "$0")"

git pull --rebase --autostash

if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -m "practice: $(date +%F' '%H:%M)"
  git push
  echo "✓ 已同步（有新数据推送）"
else
  git push 2>/dev/null || true
  echo "✓ 已同步（无新数据）"
fi
