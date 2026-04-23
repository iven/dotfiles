require('nvim-treesitter').setup {}

require('nvim-treesitter').install {
  'bash', 'cmake', 'cpp', 'css', 'dockerfile', 'fish', 'go', 'gomod', 'gowork',
  'javascript', 'json', 'lua', 'make', 'markdown', 'nix', 'python', 'regex',
  'ruby', 'rust', 'scss', 'toml', 'typescript', 'vim', 'vue', 'yaml',
}

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    local max_filesize = 100 * 1024
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
    if ok and stats and stats.size > max_filesize then
      vim.treesitter.stop(ev.buf)
      return
    end
  end,
})
