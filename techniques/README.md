# techniques/ — 技巧库

> **目的：从"硬做题"转向"带着技巧做题"。**
> 做题是为了暴露技巧盲区，不是为了刷数量。

## 文件说明

| 文件 | 内容 |
|------|------|
| [review-method.md](review-method.md) | **复盘方法论**（最重要）— 只复盘错题定位句、精听停止条件、各科复盘流程 |
| [listening.md](listening.md) | 听力题型技巧卡 + 个人错误清单 |
| [reading.md](reading.md) | 阅读题型技巧卡 + 个人错误清单 |
| [writing.md](writing.md) | 写作技巧卡（深度内容在 skills 目录的 task1-course.md） |
| [speaking.md](speaking.md) | 口语技巧卡（目标 6.0 的达标策略） |
| [mastery.yaml](mastery.yaml) | **技巧掌握度追踪** — unknown → learned → applied → mastered |
| [course-fast-track.md](course-fast-track.md) | **网课速通流程** — 定位片段、提炼技巧、真题验证、采纳/淘汰 |
| [_source-xhs-6.5.md](_source-xhs-6.5.md) | 原始素材（小红书 6.5 经验帖，含 B站资源清单） |
| [_source-planning-7.0-7.5.md](_source-planning-7.0-7.5.md) | 7.0–7.5 自学经验调研（个人经验分层 + 官方交叉验证） |

## 核心工作流

```
做题 → 错了 → 查错因属于哪个技巧 → 技巧卡怎么说 → 状态是什么？
                                            ↓
              unknown（没学过）  →  先学技巧卡，再练同类题
              learned（学过了）  →  "知道但没做到"，需要专项练
              applied（用过仍错）→  技巧理解有偏差，重读技巧卡
```

**判断标准：一个错误如果对应的技巧状态是 `unknown`，那是"不知道"；如果是 `learned` 或 `applied`，那是"做不到"。这两种问题的解法完全不同。**

## 给 AI 教练的指令

分析错题时**必须**：
1. 把每个错误映射到 `mastery.yaml` 里的技巧 id
2. 报告该技巧的当前状态，区分"不知道" vs "做不到"
3. 分析结束后更新 `mastery.yaml`（状态流转 + evidence）
4. 同步更新对应技巧卡底部的"我的高频错误"表

不要只说"这题错在没读懂"，要说"这属于 `mcq_concession_trap`（让步陷阱），技巧卡在 reading.md，你的状态是 unknown —— 先看技巧再练 3 道同类题"。

## 学习顺序（来自经验帖，已验证合理）

> 先把**阅读和听力的题型技巧**搞定（花不了多少时间），然后一边练这两科，一边学写作口语。

用户当前优先级（按 mastery.yaml 的 priority）：
1. 🔴 听力 Section 4 节奏 + 跟丢放弃策略
2. 🔴 写作拼写纪律 + Task 1 Overview
3. 🔴 阅读 Matching 三陷阱
4. 🔴 口语万能故事库（0 篇，投产比最高）
