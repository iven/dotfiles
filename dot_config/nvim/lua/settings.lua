-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
--- See: https://neovim.io/doc/user/vim_diff.html
--- [2] Defaults - *nvim-defaults*

-----------------------------------------------------------
-- General
-----------------------------------------------------------
vim.opt.fileencodings = 'ucs-bom,utf-8,gb18030,gb2312,gbk,cp936'
vim.opt.mouse = 'a'               -- Enable mouse support
vim.opt.mousemoveevent = true
vim.opt.clipboard = 'unnamedplus' -- 使用系统剪贴板，需要安装 xclip 或者 wl-clipboard
vim.opt.swapfile = false          -- Don't use swapfile
vim.opt.undofile = true           -- 保存 Undo 历史
vim.opt.undolevels = 10000
vim.opt.autochdir = true          -- 随编辑文件自动跳转目录
vim.opt.whichwrap = 'b,s,<,>,h,l' -- 设置跨行键
vim.opt.shell = '/bin/bash'       -- 设置终端
vim.opt.diffopt = 'internal,filler,closeoff,algorithm:histogram,indent-heuristic,linematch:60'
vim.opt.virtualedit = "block"     -- 块模式下光标可移到无文本处

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
vim.opt.number = true        -- Show line number
vim.opt.showmatch = true     -- Highlight matching parenthesis
vim.opt.foldmethod = 'expr'  -- Enable folding (default 'foldmarker')
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 99  -- Disable folding by default
vim.opt.colorcolumn = '80'   -- Line lenght marker at 80 columns
vim.opt.ignorecase = true    -- Ignore case letters when search
vim.opt.smartcase = true     -- Ignore lowercase for the whole pattern
vim.opt.linebreak = true     -- Wrap on word boundary
vim.opt.cursorline = true    -- 高亮当前行
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.inccommand = 'split' -- 即时显示替换结果
vim.opt.conceallevel = 0     -- 禁止 JSON, Markdown 等文件隐藏特定语法相关字符的行为
vim.opt.list = true
vim.opt.listchars:append('tab:··,trail: ,extends:↷,precedes:↶')
vim.opt.splitkeep = "screen" -- https://github.com/yetone/avante.nvim
vim.opt.winborder = 'rounded'
vim.opt.laststatus = 3       -- 全局状态栏

-----------------------------------------------------------
-- Tabs, indent（由 editorconfig 决定）
-----------------------------------------------------------
vim.opt.expandtab = true -- Use spaces instead of tabs
-- vim.opt.shiftwidth = 4     -- Shift 4 spaces when tab
-- vim.opt.tabstop = 4        -- 1 tab == 4 spaces
vim.opt.smartindent = true -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
vim.opt.hidden = true    -- Enable background buffers
vim.opt.synmaxcol = 240  -- Max column for syntax highlight
vim.opt.updatetime = 200 -- ms to wait for trigger 'document_highlight'

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------

-- Disable nvim intro
vim.opt.shortmess:append "sI"

-- Disable builtins plugins
local disabled_built_ins = {
  -- "netrw",
  -- "netrwPlugin",
  -- "netrwSettings",
  -- "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-----------------------------------------------------------
-- Clipboard
-----------------------------------------------------------

if vim.fn.has('nvim-0.10.0') == 1 then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
end

-----------------------------------------------------------
-- Autocommands
-----------------------------------------------------------

vim.api.nvim_create_augroup('user_config', {})

vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = "Search", timeout = 1200 }
  end,
  desc = '复制文本时对其进行高亮',
  group = 'user_config',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'text,markdown,html,xhtml',
  callback = function()
    vim.opt_local.colorcolumn = ''
  end,
  desc = '对于指定文件类型不使用 ColorColumn',
  group = 'user_config',
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.jinja',
  command = [[setfiletype jinja]],
  desc = '将 jinja 文件识别为 jinja',
  group = 'user_config',
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.code-workspace',
  command = [[setfiletype jsonc]],
  desc = '将 VSCode workspace 文件识别为 jsonc',
  group = 'user_config',
})

vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]],
  desc = '跳转到上次编辑位置',
  group = 'user_config',
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = vim.env.HOME .. '/.local/share/chezmoi/*',
  command = [[silent !chezmoi apply --source-path "%"]],
  desc = 'chezmoi 配置自动生效',
  group = 'user_config',
})

vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  command = [[hi IlluminatedWordText cterm=bold ctermbg=237 guibg=#3e614f gui=none]],
  desc = '强调当前变量',
  group = 'user_config',
})

vim.api.nvim_create_autocmd('CursorHold', {
  pattern = '*',
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
  desc = '自动显示诊断错误信息',
  group = 'user_config',
})

vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  pattern = '*',
  callback = function()
    local exists, lightbulb = pcall(require, "nvim-lightbulb")
    if exists then
      lightbulb.update_lightbulb()
    end
  end,
  desc = '对于 Code Action 显示灯泡图标',
  group = 'user_config',
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.keymap.set({ 'n' }, '<LeftRelease>', '<LeftRelease>i', { buffer = 0 })
  end,
  desc = '终端鼠标操作不进入 Terminal Mode',
  group = 'user_config',
})

-----------------------------------------------------------
-- User Commands
-----------------------------------------------------------

-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
