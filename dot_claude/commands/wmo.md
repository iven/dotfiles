---
description: 选择并切换到一个 worktree（使用 workmux）
allowed-tools: Bash
---

可用 worktree：

!`workmux list | tail -n +2 | grep -v '^\s*main\s'`

展示编号列表，等用户输入编号，执行 `SHELL=$(python3 -c "import pwd,os; print(pwd.getpwuid(os.getuid()).pw_shell)") workmux open <branch>`。
