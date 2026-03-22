---
name: zh-typography
description: |
  中文文案排版规范，包括空格、标点、名词大小写等规则。

  应在以下场景主动使用：
  - Claude 需要生成大段中文文字时，如创建 GitHub issue、编写 PR 描述、撰写文档、输出报告等。

  <example>
  user: "帮我把这个 bug 提交到 GitHub"
  assistant: 使用 Skill tool 调用 zh-typography skill
  <commentary>
  Claude 需要自行撰写 issue 正文，触发排版规范。
  </commentary>
  </example>
user-invocable: false
---

# 中文文案排版

## 空格使用

- 中英文之间需要加空格，如：在 Python 中使用 Quack。
- 中文与数字之间需要加空格，如：共有 10 个目标。
- 数字与单位之间需要加空格，如：大小为 20 MB。
- 链接两侧有文字时需要加空格，如：访问 [GitHub](https://github.com/paraflow-hq/quack)。
- 全角标点与其他字符之间不加空格。

## 标点符号

- 中文文本使用全角中文标点。
- 对中文的引用使用直角引号，如：「老师，『有条不紊』的『紊』是什么意思？」
- 英文整句使用半角标点，如：乔布斯那句话是怎么说的？「Stay hungry, stay foolish.」
- 中文句子内部的并列词用顿号「、」分隔。
- 中文文档中项目符号末尾需要加上句号。

## 名词处理

- 专有名词使用正确的大小写，如：GitHub、Python、iOS、macOS、Node.js。
- 技术名词保留原有格式，如：uv、quack。

## 全角和半角

- 中文标点使用全角字符。
- 数字使用半角字符，如：使用 1000 次。
- 英文字母使用半角字符。
