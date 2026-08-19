# 新 Windows 笔记本接管 Prompt

> 把本文件从标题以下完整复制给新笔记本上的 Codex、Claude Code 或其他具备终端能力的 AI。

---

# 任务：在这台 Windows 笔记本上接管并运行我的雅思 AI 教练项目

## 目标

你要实际完成接入和验收，不只是给我命令：

1. 把公开数据仓库安全克隆到 `%USERPROFILE%\.ielts`，已有仓库则安全更新。
2. 验证档案、成绩、规划、技巧库和剑10–20转录完整。
3. 配置这台电脑对仓库的 GitHub 写权限，使训练后可以推送。
4. 完整读取 `AGENTS.md` 并接管雅思教练角色。
5. 如果本机已有 Dashboard 程序包，则安装、测试并启动；没有程序包时明确报告，不得编造替代程序。
6. 最后按真实日期给出今天的训练任务。

全程使用 PowerShell。安全范围内直接执行；只有安装软件、浏览器授权、发现冲突或需要覆盖现有目录时才暂停让我操作。

## 绝对约束

- 禁止删除或覆盖已有 `.ielts` 目录。
- 禁止 `git reset --hard`、force push、擅自解决冲突或丢弃本地改动。
- 禁止运行 Dashboard 的 `seed`、`reset`、`migrate` 命令。
- 禁止让我在聊天中粘贴 GitHub PAT、OpenAI API Key、密码或任何密钥。
- 禁止把 `.env`、密钥、PDF、音频、扫描图、录音、`node_modules` 或 `dist` 放入 `.ielts`。
- 不要同时在两台设备写数据；发现另一台设备正在训练时先让我确认。
- 真题只能使用仓库 `knowledge/` 的转录文本；先用 `rg`/`grep` 定位行号，再读取小范围，禁止整册载入和编造内容。

## 第一阶段：读取真实时间与检查环境

先运行：

```powershell
Get-Date -Format "yyyy-MM-dd HH:mm:ss zzz"
git --version
```

后续日期和考试倒计时必须使用该系统时间。

如果 Git 不存在，说明情况并征得我同意后运行：

```powershell
winget install --id Git.Git -e --source winget
```

安装后若 PATH 未刷新，让我重新打开终端，不要重复安装。

## 第二阶段：幂等克隆或更新数据仓库

仓库已公开，读取和克隆不需要登录。执行下面的等价逻辑：

```powershell
$Repo = Join-Path $env:USERPROFILE ".ielts"
$ExpectedRemote = "https://github.com/zehouzhang0-lang/ielts-data.git"

if (Test-Path -LiteralPath (Join-Path $Repo ".git")) {
    $ActualRemote = git -C $Repo remote get-url origin
    if ($ActualRemote -ne $ExpectedRemote) {
        throw "现有 .ielts 指向其他远端，停止操作。当前远端：$ActualRemote"
    }
    git -C $Repo pull --rebase --autostash
    if ($LASTEXITCODE -ne 0) {
        throw "拉取失败。保留现场，禁止 reset、强推或丢弃数据。"
    }
}
elseif (Test-Path -LiteralPath $Repo) {
    throw "$Repo 已存在但不是目标 Git 仓库。停止操作，等待我决定如何处理。"
}
else {
    git clone $ExpectedRemote $Repo
    if ($LASTEXITCODE -ne 0) { throw "克隆失败，停止操作。" }
}
```

不要把旧 commit SHA 写成固定验收值，因为训练数据会持续更新。

## 第三阶段：完整性验收

运行：

```powershell
Set-Location $Repo
git fetch origin main
git remote -v
git branch --show-current
git status --short --branch
git rev-parse HEAD
git rev-parse origin/main
git fsck --full

$Required = @(
  "AGENTS.md",
  "SCHEMA.md",
  "profile.md",
  "scores.md",
  "planning\strategy.yaml",
  "techniques\mastery.yaml",
  "sync.ps1"
)
foreach ($File in $Required) {
  if (-not (Test-Path -LiteralPath (Join-Path $Repo $File))) {
    throw "缺少核心文件：$File"
  }
}

$TranscriptCount = (Get-ChildItem (Join-Path $Repo "knowledge") -File -Filter "剑*_视觉转录.md").Count
if ($TranscriptCount -ne 11) {
  throw "剑桥转录数量异常：期望 11，实际 $TranscriptCount"
}
```

验收必须同时满足：remote 正确、分支为 `main`、`HEAD` 等于 `origin/main`、worktree clean、Git 对象无损坏、核心文件齐全、剑10–20共 11 份转录。

## 第四阶段：配置写权限

公开仓库无需登录即可读取，但推送训练进度必须登录 GitHub 账号 `zehouzhang0-lang`。

先检查：

```powershell
gh --version
gh auth status --hostname github.com
```

若 GitHub CLI 不存在，征得我同意后安装：

```powershell
winget install --id GitHub.cli -e --source winget
```

若尚未登录，只允许使用浏览器授权：

```powershell
gh auth login --hostname github.com --git-protocol https --web
gh auth setup-git
```

不要运行会显示 token 的命令。不要让我把 token 发到聊天。检查 Git 提交身份：

```powershell
git config --global user.name
git config --global user.email
```

任何一项为空就询问我，禁止猜邮箱。随后验证写权限，不制造测试提交：

```powershell
git -C $Repo push --dry-run origin main
```

## 第五阶段：接管教练规则

完整读取：

```powershell
Get-Content -Raw (Join-Path $Repo "AGENTS.md")
Get-Content -Raw (Join-Path $Repo "profile.md")
Get-Content -Raw (Join-Path $Repo "scores.md")
```

首次写入数据前，必须再完整读取 `SCHEMA.md`。`AGENTS.md` 优先于 README 的简化说明。

此后每次会话固定执行：

1. 读取系统真实时间。
2. `git -C $Repo pull --rebase --autostash`。
3. 读取 `profile.md` 和 `scores.md`。
4. 按 `SCHEMA.md` 写入训练记录并更新相关技巧 mastery。
5. 先展示 `git status --short`，确认只有合理数据文件。
6. Windows 运行 `& (Join-Path $Repo "sync.ps1")` 提交并推送。

仓库没有根级 `.gitignore`，而 `sync.ps1` 会执行 `git add -A`。请在本机 `.git/info/exclude` 中以不覆盖原内容的方式加入 `.env*`、`*.key`、`*.pem`、`*.pfx`、`*.p12`、`*.pdf`、常见音频格式、`node_modules/`、`dist/` 和 `.ielts-media/`。这只是额外防线；所有大文件和秘密仍必须放在仓库外。

## 第六阶段：Dashboard（条件执行）

数据仓库与 Dashboard 是两部分。目前公开的 `ielts-data` 不包含 Dashboard 源码。先检查：

```powershell
$Dashboard = Join-Path $env:USERPROFILE ".claude\skills\ielts-dashboard\dashboard"
Test-Path (Join-Path $Dashboard "package.json")
```

### 如果 `package.json` 不存在

报告：`数据仓库已接入，但 Dashboard 程序包尚未迁移。`

不要从网络猜同名项目，不要临时重写 Dashboard。询问我提供独立 Dashboard GitHub 仓库地址，或从旧电脑复制的已校验 ZIP。

当前旧电脑可用的完整 v3.2 ZIP：

```text
C:\Users\Administrator\Documents\New project\ielts-dashboard-planning-final-20260813-122124.zip
SHA-256: CBF9B57622EACE037B057BD0C7AB88D6B8D09E9E63363E32780BA9EC5BA43B62
```

如果 ZIP 已复制到新机，先让我给出新机绝对路径并校验 SHA-256；目标目录已存在时不得覆盖。确认后把 ZIP 内容解压到 `$Dashboard`。

### 如果 `package.json` 已存在

检查：

```powershell
node --version
npm --version
```

Node 必须 ≥18；缺失或过旧时征得同意后安装 Node.js LTS，并在新终端继续。然后：

```powershell
Set-Location $Dashboard
npm ci
npm run validate
npm run test:vocab
npm run test:speaking
npm run test:planning
npm run build
```

禁止运行 `seed`、`reset`、`migrate`。全部测试通过后检查端口：

```powershell
Get-NetTCPConnection -State Listen -LocalPort 4000,5173 -ErrorAction SilentlyContinue
```

若端口被占，先识别 PID 和命令行。只在确认是旧 Dashboard/Vite 后让我关闭；禁止盲目结束所有 Node 进程。5173 使用 strict port，不会自动跳到 5174。

启动：

```powershell
$env:IELTS_HOME = $Repo
npm start
```

保持该终端运行。启动后验收：

```powershell
Invoke-RestMethod http://127.0.0.1:4000/api/health
Invoke-WebRequest http://127.0.0.1:5173 -UseBasicParsing
Invoke-RestMethod http://127.0.0.1:4000/api/profile
```

必须确认 API health 的 `ok=true`、数据目录指向 `$Repo`、首页 HTTP 200、profile 能读出用户档案。

首次迁移不要配置或迁移 `OPENAI_API_KEY`。Realtime 未配置是正常状态；口语页仍可使用本地读题和录音模式。

## 本地素材边界

以下内容不在 Git，缺失不代表克隆失败：

- `%USERPROFILE%\.ielts-media\speaking-recordings`：旧口语录音。
- `D:\IELTS`：听力音频。
- `D:\ielts-knowledge-base`：扫描/PDF素材。
- `D:\雅思词汇`：原始词汇 PDF。

需要时只能从旧电脑做本地复制，禁止放进 `.ielts` 后同步。没有音频时不得拿 transcript 冒充听力训练。

## 最终汇报格式

完成后只汇报：

1. 系统时间与时区。
2. Git/Node 版本。
3. 数据仓库路径、remote、branch、短 commit、是否 clean、是否具备 push 权限。
4. 剑桥转录数量。
5. 从 profile/scores 读取的目标分、考期、四科现状和两大弱项。
6. Dashboard 是已启动，还是因缺程序包尚未迁移；若启动，给出 URL 和测试结果。
7. 哪些 PDF、音频、历史录音仍缺失。
8. 根据真实日期计算的剩余天数，以及今天按数字安排的训练任务。

不要空洞鼓励，不得编造仓库中不存在的数据。
