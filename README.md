# IELTS 备考数据仓库

雅思备考 AI 教练系统的数据仓库。所有练习记录以 Markdown + frontmatter 存储，由任意 AI 编程环境（Claude Code / Codex / 其他）读写，多设备通过 git 同步。

## 目录结构

```
.ielts/
├── profile.md                  # 用户档案（目标分/考试日期/当前水平）
├── scores.md                   # 模考分数历史
├── writing/submissions/        # 写作批改记录
├── reading/submissions/        # 阅读精读记录
├── reading/synonyms/           # 同义替换积累
├── listening/submissions/      # 听力错题记录
├── speaking/stories/           # 口语万能故事
├── vocab/days/                 # 每日词汇记录
└── typing/sessions/            # 打字练习记录
```

## 多环境同步

**每次开始学习前：**
```bash
git pull
```

**每次学习结束后：**
```bash
git add -A && git commit -m "practice: $(date +%F)" && git push
```

或直接跑仓库里的同步脚本：`./sync.sh`（Git Bash / Codex）或 `./sync.ps1`（PowerShell）。

## 数据规范

所有 `.md` 文件带 YAML frontmatter，字段规范见 Claude skills 目录的 `SCHEMA.md`。
可视化仪表板：`~/.claude/skills/ielts-dashboard/dashboard`（`npm start` → http://localhost:5173）。
