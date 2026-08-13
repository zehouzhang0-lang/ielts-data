---
type: methodology
scope: external_courses
created: "2026-08-13"
source: 用户需求 + techniques/_source-xhs-6.5.md
---

# 网课速通流程

> 目标不是“看完课程”，而是把能修复当前失分的片段转成技巧卡，并用 Cambridge 真题验证。

## 资源登记

每门课先记 6 个字段：

- 讲师/频道
- 精确标题与 URL/BV 号
- 总时长
- 章节和时间戳
- 对应 `technique_id`
- 状态：`not_started → skimmed → extracted → tested → adopted/rejected`

没有精确链接、章节和实际观看记录的推荐，只能标记为 `unverified_lead`。

## 速通步骤

1. 先看目录和章节标题，1.5-2 倍速扫一遍；只定位与当前 priority 1 技巧相关的段落。
2. 每个片段最多提炼四项：一句主张、适用题型、一个反例、一个训练动作。
3. 不因讲师声称有效就升级为技巧；必须在官方评分标准或 Cambridge 真题中验证。
4. 验证时做 3 道同类题或 1 个 Section，记录是否有意识使用及结果。
5. 有改善才 `adopted`；无改善、规则过度绝对或与题目冲突则 `rejected`。

## 当前观看顺序

按现有真实数据排序：

1. 听力 Section 4 节奏/跟丢恢复：对应 `s4_lecture_rhythm`、`abandon_and_move_on`。
2. 写作 Task 1 Overview：对应 `task1_overview`。
3. 阅读 Matching Features：对应 `matching_one_letter_rule`、`matching_person_view`。
4. 口语 Part 3 观点框架：对应 `part3_frameworks`。

## 保存边界

- Git 只保存自己的摘要、链接、时间戳、验证题和结论。
- 完整付费课程视频、音频和未经许可的全文字幕留在合法本机来源，不进仓库、不二次分发。
- 小红书/B站单人经验必须保留来源等级，不写成官方规则。

## 单节课程的完成标准

```text
定位 1 个技巧片段
→ 写 1 张四项摘要
→ 做 3 题或 1 个 Section
→ 记录 evidence
→ adopted / rejected
```

只有完成验证才算“速通一节”；单纯播放完不计进度。
