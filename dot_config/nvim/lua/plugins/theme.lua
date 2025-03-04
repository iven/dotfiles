require('onedark').setup({
  transparent = false,                     -- Show/hide background
  term_colors = true,                      -- Change terminal color as per the selected theme style
  ending_tildes = false,                   -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false,            -- reverse item kind highlights in cmp menu
  -- toggle theme style ---
  toggle_style_key = "<leader>bg",         -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
  toggle_style_list = { 'dark', 'light' }, -- List of styles to toggle between
  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
  code_style = {
    comments = 'italic',
    keywords = 'italic',
    functions = 'none',
    strings = 'none',
    variables = 'none'
  },
  -- Lualine options --
  lualine = {
    transparent = true, -- lualine center bar transparency
  },
  -- Custom Highlights --
  colors = {}, -- Override default colors
  highlights = {
    ["@constant.builtin"] = { fmt = 'italic' },
    ["@function.builtin"] = { fmt = 'italic' },
    ["@type.builtin"] = { fmt = 'italic' },
    ["@variable.builtin"] = { fmt = 'italic' },
  }, -- Override highlight groups
  -- Plugins Config --
  diagnostics = {
    darker = true,     -- darker colors for diagnostic
    undercurl = true,  -- use undercurl instead of underline for diagnostics
    background = true, -- use background color for virtual text
  },
})
require('onedark').load()
