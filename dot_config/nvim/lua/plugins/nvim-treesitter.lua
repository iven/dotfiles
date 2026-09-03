require('nvim-treesitter').setup {
  install_dir = vim.fn.stdpath('data') .. '/site',
}

require('nvim-treesitter').install {
  'bash', 'cmake', 'cpp', 'css', 'dockerfile', 'fish', 'go', 'gomod', 'gowork',
  'javascript', 'json', 'lua', 'make', 'markdown', 'nix', 'python', 'regex',
  'ruby', 'rust', 'scss', 'toml', 'typescript', 'vim', 'vue', 'yaml',
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    -- 大文件不启用 treesitter
    local max_filesize = 100 * 1024
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
    if ok and stats and stats.size > max_filesize then
      vim.treesitter.stop(ev.buf)
      return
    end

    local filetype = vim.bo[ev.buf].filetype
    if filetype == '' then
      return
    end

    local lang = vim.treesitter.language.get_lang(filetype)
    local ok_add, has_parser = pcall(vim.treesitter.language.add, lang)
    if not ok_add or not has_parser then
      return
    end

    -- 高亮
    pcall(vim.treesitter.start, ev.buf)

    -- 缩进（对应旧版 indent.enable）
    local ok_query, query = pcall(vim.treesitter.query.get, lang, 'indents')
    if ok_query and query then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
