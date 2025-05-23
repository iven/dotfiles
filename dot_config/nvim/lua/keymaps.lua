-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Change leader to a comma
vim.g.mapleader = ','

-- 回车选择当前单词
vim.keymap.set('n', '<cr>', 'viw')

-- Clear search highlighting with <leader> and c
vim.keymap.set('n', '<leader><space>', '<cmd>nohl<cr>')

-- 空格键打开或者关闭折叠
vim.keymap.set('n', '<space>', 'za')

-- Don't use arrow keys
vim.keymap.set('', '<up>', '<nop>')
vim.keymap.set('', '<down>', '<nop>')
vim.keymap.set('', '<left>', '<nop>')
vim.keymap.set('', '<right>', '<nop>')

-- 折行算作一行
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- 分号当作冒号
vim.keymap.set('n', ';', ':')

-- Visual 模式粘贴时，不覆盖剪贴板
vim.keymap.set('v', 'p', '"_s<esc>p')

-- 禁用鼠标跳转 Tag 行为
vim.keymap.set('n', '<C-LeftMouse>', '<Nop>')

-- Fast saving with <leader> and w
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')

-- Move around splits using Ctrl + {h,j,k,l}
-- vim-kitty-navigator 已经提供此功能
-- vim.keymap.set('n', '<C-h>', '<C-w>h')
-- vim.keymap.set('n', '<C-j>', '<C-w>j')
-- vim.keymap.set('n', '<C-k>', '<C-w>k')
-- vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Terminal 下使用 Ctrl + {h,j,k,l} 来切换窗口
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l')

-- Close all windows and exit from Neovim
vim.keymap.set('n', '<leader>q', '<cmd>qa!<cr>')

-- 快速编辑和重载 init.lua
vim.keymap.set('n', '<leader>e', '<cmd>e ~/.local/share/chezmoi/dot_config/nvim/init.lua<cr>')

-- 快速打开 Lazy
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>')

-- 防止误触
vim.keymap.set('n', 'q:', '<esc>')
vim.keymap.set({ 'n', 'i' }, '<F1>', '<esc>')

-- 切换亮暗主题(set background)
vim.keymap.set('n', '<leader>bg',
  function()
    vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'
  end
)
