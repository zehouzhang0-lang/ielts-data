# knowledge/ — 剑桥真题库（转录版）

剑10–20 共 11 册，每册一个 `剑{N}_视觉转录.md`，人工逐页转录（非 OCR），是**可信文本源**：

- 每个 Test 的完整题目（Listening 4 Parts + Reading 3 Passages + Writing 2 Tasks）
- **Answer Keys**（听力/阅读官方答案）
- **Audioscripts**（听力原文，精听用）

## 用法

- 定位章节：`grep -n "^## Test\|^### " 剑15_视觉转录.md` 拿行号，按区间读取，别整册读入
- 出题闭环：从转录版出题 → 用户作答 → 对 Answer Key 判分 → 写 submission 到对应目录
- 页码溯源：文件内 `<!-- img: 剑15真题_11.png · 印刷页10 -->` 注释对应原书扫描图

## 扫描图和 PDF 在哪

原版 PDF + 逐页 PNG 扫描图（约 1.6GB，剑10–15）**不进本仓库**，仅存于主力机 `D:\ielts-knowledge-base\`。
只有在转录文本存疑需要溯源时才用得到；其他环境正常训练用本目录的转录版即可。
