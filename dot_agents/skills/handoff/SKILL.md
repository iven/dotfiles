---
name: handoff
description: 将当前对话压缩成交接文档，供下一个 agent 接手继续工作。
argument-hint: 下一个会话要用来做什么？
---

# Handoff

写一份交接文档，总结当前会话的进展，让一个全新的 agent 能够接手继续工作。把内容展示给用户，然后询问用户是否创建 GitHub issue。

如果下一个会话需要用到某些 skill，在文档里列出建议使用的 skill。

不要重复已经记录在其他产物里的内容（PRD、方案、ADR、issue、commit、diff），用路径或 URL 引用即可。

如果用户传入了参数，把参数视为下一个会话的关注点描述，据此调整文档内容。
