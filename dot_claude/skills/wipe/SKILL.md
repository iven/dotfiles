---
name: wipe
description: 重置当前分支到 origin/main 最新状态。
user-invocable: true
disable-model-invocation: true
allowed-tools: Bash(git:*)
---

# Wipe

未合并的 commit：

!`git fetch origin 2>/dev/null; ~/.claude/skills/wipe/scripts/check-unmerged-commits.sh`

如果上面输出为 `(none)`，直接重置，无需确认。否则展示给用户并用 AskUserQuestion 确认，取消则终止。

确认后执行：

```bash
git reset --hard origin/main
```
