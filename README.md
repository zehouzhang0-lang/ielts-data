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
├── typing/sessions/            # 打字练习记录
└── planning/                   # 策略、每日计划快照与追加式完成事件
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

## 真题知识库

仓库 `knowledge/` 内有剑桥雅思 10–20 的人工转录文本，含题目、Answer Keys 和 Audioscripts。题目必须从这些文本定位并记录行号，不得编造。

原版 PDF、扫描图和音频体积大，不进 Git。当前主力机剑15 PDF 与 Test 1–4 音频位于 `D:\IELTS\`；`D:\ielts-knowledge-base\` 主要保留扫描/转录素材。规划器只有在本机确认音频存在时才安排对应听力题；其他书目需先补齐合法音频。

## 数据规范

所有数据字段规范见仓库根目录的 `SCHEMA.md`。
可视化仪表板：`~/.claude/skills/ielts-dashboard/dashboard`（`npm start` → http://localhost:5173）。
