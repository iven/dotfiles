require("nvim-treesitter.configs").setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    'bash', 'cmake', 'comment', 'cpp', 'css', 'dockerfile', 'fish', 'go', 'gomod', 'gowork',
    'javascript', 'json', 'lua', 'make', 'markdown', 'nix', 'python',
    'ruby', 'rust', 'scss', 'toml', 'typescript', 'vim', 'vue', 'yaml',
  },
  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- List of parsers to ignore installing
  ignore_install = {},
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      -- https://github.com/camdencheek/tree-sitter-dockerfile/issues/4
      if lang == "dockerfile" then
        return true
      end
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      scope_incremental = "<cr>",
    },
  },
  indent = {
    enable = true,
  },
}
