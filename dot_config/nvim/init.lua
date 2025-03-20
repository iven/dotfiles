vim.loader.enable()

require('settings')
require('keymaps')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  {
    'mhinz/vim-startify',
    config = function() require('plugins.startify') end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-telescope/telescope-fzy-native.nvim', build = 'make -C deps/fzy-lua-native' },
    },
    config = function() require('plugins.telescope') end,
    keys = {
      { '<C-p>',     function() require('telescope.builtin').git_files() end },
      { '<leader>f', function() require('telescope.builtin').find_files() end },
      {
        '<leader>a',
        function()
          local git_root, _ = require('telescope.utils').get_os_command_output({ "git", "rev-parse", "--show-toplevel" })
          require('telescope.builtin').live_grep { cwd = git_root[1] }
        end,
      },
    },
  },
  {
    'debugloop/telescope-undo.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { "<leader>u", "<cmd>Telescope undo<cr>" },
    },
  },
  -- 外观
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function() require('plugins.nvim-treesitter') end,
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require 'rainbow-delimiters.setup' {
        strategy = {
          [''] = require('rainbow-delimiters').strategy['global'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        blacklist = { 'json' },
      }
    end,
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('plugins.bufferline')
    end,
    keys = {
      { "<C-t>",     "<cmd>BufferLinePick<cr>" },
      { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>" },
      { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>" },
      { "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>" },
      { "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>" },
      { "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>" },
      { "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>" },
      { "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>" },
      { "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>" },
      { "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>" },
      { "<leader>$", "<cmd>BufferLineGoToBuffer -1<cr>" },
    },
    lazy = false,
  },
  {
    "utilyre/barbecue.nvim",
    version = "*",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup {
        attach_navic = false,
        show_modified = true,
      }
      vim.g.navic_silence = true
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      require('lualine').setup {
        sections = {
          lualine_b = { 'filename', 'progress', 'diff', 'diagnostics' },
          lualine_c = {
            {
              require("noice").api.status.message.get,
              cond = require("noice").api.status.message.has,
              color = { fg = "#8ebd6b" },
            },
            {
              'searchcount',
              color = { fg = "#8ebd6b" },
            },
          },
          lualine_x = { 'fileformat' },
          lualine_y = { 'filetype' },
          lualine_z = { 'branch' },
        },
        inactive_sections = {
          lualine_c = {
            { 'filename', path = 2 },
          },
          lualine_x = { 'branch' },
        },
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function() require('gitsigns').setup() end,
  },
  {
    "ivanjermakov/troublesum.nvim",
    config = function()
      require("troublesum").setup()
    end
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function() require('plugins.indent_blankline') end,
  },
  {
    'navarasu/onedark.nvim',
    config = function() require('plugins.theme') end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        require('onedark').set_options('style', 'dark')
        require('onedark').set_options('toggle_style_index', 2)
        vim.api.nvim_command('colorscheme onedark')
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        require('onedark').set_options('style', 'light')
        require('onedark').set_options('toggle_style_index', 1)
        vim.api.nvim_command('colorscheme onedark')
      end,
      update_interval = 1000,
      fallback = "dark"
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function() require('colorizer').setup({}) end,
    ft = { 'vim', 'lua', 'css', 'kitty' },
  },
  {
    'prichrd/netrw.nvim',
    config = function() require 'netrw'.setup({}) end,
    ft = 'netrw',
  },
  {
    'johnfrankmorgan/whitespace.nvim',
    config = function()
      require('whitespace-nvim').setup({
        highlight = 'DiffText',
        ignored_filetypes = {
          'TelescopePrompt',
          'Trouble',
          'git.nvim',
          'help',
          'lazy',
          'lspinfo',
          'noice',
          'toggleterm',
        },
      })
    end
  },
  {
    'm4xshen/smartcolumn.nvim',
    config = function()
      require("smartcolumn").setup({
        colorcolumn = '80',
        disabled_filetypes = {
          'help', 'html', 'markdown', 'text', 'xhtml',
        },
        limit_to_window = true,
      })
    end
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        views = {
          cmdline_popup = {
            position = {
              row = -2,
              col = 6,
            },
          },
          popupmenu = {
            position = {
              row = -5,
              col = 5,
            },
          },
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false,        -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true,        -- add a border to hover docs and signature help
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              kind = { '', 'echo', 'echomsg', 'return_prompt', 'search_count' },
              ["not"] = {
                find = "\n",
              },
            },
            opts = { skip = true },
          },
        },
      })
    end,
  },
  -- 语法
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- 启用基于 LSP 的自动补全
      'hrsh7th/cmp-nvim-lsp',
      -- 保存时自动格式化文件
      'lukas-reineke/lsp-format.nvim',
      -- 高亮光标下的变量及其定义和使用
      'RRethy/vim-illuminate',
    },
    config = function() require('plugins.lspconfig') end,
    keys = {
      { 'gd', function() vim.lsp.buf.definition() end },
      { 'gD', function() vim.lsp.buf.type_definition() end },
      --
      { 'gI', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ nil })) end },
      --
      { '[d', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end },
      { ']d', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end },
      --
      {
        '<leader>ca',
        function()
          -- 加载 ui-select
          require('telescope')
          vim.lsp.buf.code_action()
        end,
      },
      { '<leader>F', function() vim.lsp.buf.format({ async = true }) end },
      { '<leader>R', function() vim.lsp.buf.rename() end },
      --
      { 'gwa',       function() vim.lsp.buf.add_workspace_folder() end },
      { 'gwr',       function() vim.lsp.buf.remove_workspace_folder() end },
      { 'gwl',       function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end },
    },
  },
  {
    'stevearc/conform.nvim',
    cond = vim.fn.has('nvim-0.10.0') == 1,
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_organize_imports", "ruff_format" },
          javascript = { "prettier" },
          css = { "prettier" },
          json = { "prettier" },
        },
        format_on_save = {
          lsp_format = "fallback",
          timeout_ms = 1000,
        },
      })
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lua',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'lukas-reineke/cmp-under-comparator',
      -- 在补全菜单显示类似 VSCode 的图标
      'onsails/lspkind-nvim',
    },
    config = function() require('plugins.cmp') end,
    event = 'InsertEnter',
  },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        virtual_text = {
          enabled = true,
          idle_delay = 0,
          key_bindings = {
            accept = '<c-f>',
            prev = '<c-k>',
            next = '<c-j>',
          },
        }
      })
    end,
    event = 'InsertEnter',
  },
  {
    "yetone/avante.nvim",
    cond = vim.fn.has('nvim-0.10.0') == 1,
    event = "VeryLazy",
    lazy = false,
    build = "make",
    opts = {
      provider = "openai",
      openai = {
        endpoint = "https://api.deepbricks.ai/v1/",
        model = "claude-3.5-sonnet",
        disable_tools = true,
      },
      cursor_applying_provider = 'groq', -- In this example, use Groq for applying, but you can also use any provider you want.
      behaviour = {
        --- ... existing behaviours
        enable_cursor_planning_mode = true, -- enable cursor planning mode!
      },
      rag_service = {
        enabled = false, -- Enables the rag service, requires OPENAI_API_KEY to be set
      },
      vendors = {
        --- ... existing vendors
        groq = { -- define groq provider
          __inherited_from = 'openai',
          api_key_name = 'GROQ_API_KEY',
          endpoint = 'https://api.groq.com/openai/v1/',
          model = 'llama-3.3-70b-versatile',
          max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
        },
      },
      mappings = {
        submit = {
          insert = "<cr>",
        },
      }
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below is optional, make sure to setup it properly if you have lazy=true
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('trouble').setup {
        auto_close = true,
        auto_jump = { 'lsp_definitions', 'lsp_type_definitions' },
        focus = true,
        pinned = true,
      }
    end,
    keys = {
      { '<leader>d', function() require('trouble').toggle({ mode = 'diagnostics', filter = { buf = 0, severity = vim.diagnostic.severity.ERROR } }) end },
      { '<leader>D', function() require('trouble').toggle({ mode = 'diagnostics', filter = { vim.diagnostic.severity.ERROR } }) end },
      { 'gr',        function() require('trouble').toggle({ mode = 'lsp_references' }) end },
      { 'gi',        function() require('trouble').toggle({ mode = 'lsp_implementations' }) end },
    },
    cmd = 'Trouble',
  },
  'kosayoda/nvim-lightbulb',
  -- 编辑
  {
    'windwp/nvim-autopairs',
    config = function() require('plugins.nvim-autopairs') end,
    event = 'InsertEnter',
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          jump_labels = true
        }
      }
    },
    keys = {
      -- { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    'RRethy/nvim-treesitter-endwise',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function() require('nvim-treesitter.configs').setup { endwise = { enable = true } } end,
    ft = { 'ruby', 'lua', 'vimscript', 'bash' },
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require("ts_context_commentstring").setup {}
      vim.g.skip_ts_context_commentstring_module = true
    end
  },
  {
    'Wansmer/treesj',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('treesj').setup {
        use_default_keymaps = false,
        max_join_length = 1024,
      }
    end,
    keys = {
      { '<leader>jm', function() require('treesj').toggle() end },
      { '<leader>js', function() require('treesj').split() end },
      { '<leader>jj', function() require('treesj').join() end },
    },
  },
  {
    'assistcontrol/readline.nvim',
    keys = {
      { '<M-f>', function() require('readline').forward_word() end,       mode = '!' },
      { '<M-b>', function() require('readline').backward_word() end,      mode = '!' },
      { '<C-a>', function() require('readline').beginning_of_line() end,  mode = '!' },
      { '<C-e>', function() require('readline').end_of_line() end,        mode = '!' },
      { '<M-d>', function() require('readline').kill_word() end,          mode = '!' },
      { '<C-w>', function() require('readline').backward_kill_word() end, mode = '!' },
      { '<C-k>', function() require('readline').kill_line() end,          mode = '!' },
      { '<C-u>', function() require('readline').backward_kill_line() end, mode = '!' },
      -- { '<C-f>', '<Right>',                                               mode = '!' },
      -- { '<C-b>', '<Left>',                                                mode = '!' },
      -- { '<C-n>', '<Down>',                                                mode = '!' },
      -- { '<C-p>', '<Up>',                                                  mode = '!' },
      { '<C-d>', '<Delete>',                                              mode = '!' },
      { '<C-h>', '<BS>',                                                  mode = '!' },
    },
  },
  {
    'tpope/vim-abolish',
    cmd = 'S',
  },
  {
    'mg979/vim-visual-multi',
    config = function()
      local VM_maps = vim.g.VM_maps or {}
      VM_maps["Select Operator"] = ''
      vim.g.VM_maps = VM_maps

      local VM_custom_remaps = vim.g.VM_custom_remaps or {}
      VM_custom_remaps["s"] = 'c'
      vim.g.VM_custom_remaps = VM_custom_remaps
    end
  },
  -- 其他
  {
    'FabijanZulj/blame.nvim',
    config = function()
      require('blame').setup {
        date_format = "%Y-%m-%d %H:%M:%S",
      }
    end,
    keys = {
      { '<leader>gb', '<cmd>BlameToggle<cr>', mode = 'n' },
    },
  },
  {
    'tpope/vim-eunuch',
    cmd = {
      'SudoEdit', 'SudoWrite', 'Remove', 'Rename', 'Delete', 'Move', 'Unlink',
    },
    keys = {
      { '<leader>W', '<cmd>SudoWrite<cr>', mode = 'n' },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = '*',
    config = function()
      require('toggleterm').setup {
        open_mapping = "<c-`>",
        direction = 'float',
        shell = 'fish',
        winbar = {
          enabled = true,
        },
      }
    end,
  },
  {
    'knubie/vim-kitty-navigator',
    build = 'cp ./*.py ~/.config/kitty/',
  },
  {
    'h-hg/fcitx.nvim',
    event = 'InsertEnter',
  }
})
