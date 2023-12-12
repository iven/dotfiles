require("ibl").setup {
  scope = {
    show_exact_scope = true,
  },
  exclude = {
    filetypes = {
      'help',
      'git',
      'markdown',
      'text',
      'terminal',
      'lspinfo',
      'packer',
      'startify',
    },
    buftypes = {
      'terminal',
      'nofile',
    },
  },
}
