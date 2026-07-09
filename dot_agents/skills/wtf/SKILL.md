---
name: wtf
description: |
  处理用户不满并进行自我审查，修正行为模式。

  应在以下场景主动使用：
  - 用户说「wtf」等表达不满时
  - 用户连续问同一句话质疑时

  <example>
  user: "你是不是傻！"
  assistant: 使用 Skill tool 调用 wtf skill
  <commentary>
  用户表达强烈不满，触发 wtf skill 进行自我审查。
  </commentary>
  </example>
user-invocable: true
---

# 流程

此 Skill 被调用，说明你一定已经犯了错误，你需要立即反思错误，调整行动方向。你需要读取 AGENTS.md 中「行为指南」章节，判断自己是否犯了里面说的错误，并对行为模式和行动方向进行修正（不仅是承认错误）。

如果对用户不满的原因没有把握，那么应该给出 2-3 种可能的解释（注意逻辑，不要将明显不合理的解释展示出来）让用户进行澄清。
