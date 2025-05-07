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
  -- 外观
  {
    'goolord/alpha-nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require 'alpha'.setup(require 'plugins.startify'.config)
    end
  },
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
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {
      separator = "  ",
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('lualine').setup {
        sections = {
          lualine_b = { 'filename', 'progress', 'diff', 'diagnostics' },
          lualine_c = {
            {
              require("noice").api.status.message.get,
              cond = require("noice").api.status.message.has,
              color = { fg = "#d7827e" },
            },
            {
              'searchcount',
              color = { fg = "#d7827e" },
            },
          },
          lualine_x = { 'fileformat' },
          lualine_y = { 'filetype' },
          lualine_z = { 'branch' },
        },
        winbar = {
          lualine_c = {
            {
              'filetype',
              icon_only = true,
              separator = { left = '', right = '' },
              padding = { left = 1, right = 0 },
              cond = function()
                return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "nofile"
              end
            },
            {
              'filename',
              padding = { left = 0, right = 1 },
              cond = function()
                return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "nofile"
              end
            },
            {
              function()
                return require("nvim-navic").get_location()
              end,
              cond = function()
                return require("nvim-navic").is_available()
              end
            },
          }
        },
        inactive_winbar = {
          lualine_c = {
            {
              'filetype',
              icon_only = true,
              separator = { left = '', right = '' },
              padding = { left = 1, right = 0 },
              cond = function()
                return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "nofile"
              end
            },
            {
              "filename",
              path = 2,
              padding = { left = 0, right = 1 },
              cond = function()
                return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "nofile"
              end
            },
          },
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
    "rose-pine/neovim",
    name = "rose-pine",
    config = function() require('plugins.theme') end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000,
      -- 在官方方案合入前，先写死一个按时间来判断的逻辑
      fallback = (tonumber(os.date("%H")) >= 6 and tonumber(os.date("%H")) < 18) and 'light' or 'dark',
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
    event = "VeryLazy",
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
          -- neovim 0.11 后不再需要
          hover = { enabled = false },
          signature = { enabled = false },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false,        -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
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
      -- 高亮光标下的变量及其定义和使用
      'RRethy/vim-illuminate',
      -- 自动补全
      'saghen/blink.cmp',
    },
    config = function() require('plugins.lspconfig') end,
    keys = {
      { 'gd', function() vim.lsp.buf.definition() end },
      { 'gD', function() vim.lsp.buf.type_definition() end },
      --
      { 'gI', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ nil })) end },
      --
      {
        'gra',
        function()
          -- 加载 ui-select
          require('telescope')
          vim.lsp.buf.code_action()
        end,
      },
      { '<leader>F', function() vim.lsp.buf.format({ async = true }) end },
      --
      { 'gwa',       function() vim.lsp.buf.add_workspace_folder() end },
      { 'gwr',       function() vim.lsp.buf.remove_workspace_folder() end },
      { 'gwl',       function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end },
    },
  },
  {
    'stevearc/conform.nvim',
    cond = vim.fn.has('nvim-0.10.0') == 1,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        cmake = { "gersemi", timeout_ms = 2000 },
        css = { "prettier" },
        javascript = { "prettier" },
        json = { "prettier" },
        nix = { "nixfmt" },
        python = { "ruff_organize_imports", "ruff_format" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 1000, lsp_format = "fallback" }
      end,
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      "xzbdmw/colorful-menu.nvim",
      { "saghen/blink.compat", opts = { enable_events = true } },
    },
    -- 需要用 rustup 来装： rustup component add --toolchain nightly-aarch64-apple-darwin cargo
    build = 'cargo build --release',
    opts = {
      keymap = {
        preset = 'enter',
        ['<C-n>'] = { 'show', 'select_next', 'fallback_to_mappings' },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
      appearance = {
        nerd_font_variant = 'mono'
      },
      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
        documentation = { auto_show = true },
        keyword = { range = 'full' },
        menu = {
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            columns = {
              { "label",     gap = 1 },
              { "kind_icon", "kind", gap = 1 },
            },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },
      cmdline = {
        completion = {
          menu = {
            auto_show = true,
          },
          list = {
            selection = {
              preselect = false,
            },
          },
        },
      },
      sources = {
        default = { 'codeium', 'snippets', 'lsp', 'buffer', 'path' },
        providers = {
          -- Codeium 行为比较奇怪，只有在手动 C-n 的时候才会自动补全
          codeium = {
            name = "codeium",
            module = "blink.compat.source",
            async = true,
            score_offset = 30,
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      -- blink 的 signature 不知为何显示不全，所以暂时使用 C-s 手动触发
      signature = { enabled = false },
    },
    opts_extend = { "sources.default" }
  },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
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
      { 'grr',       function() require('trouble').toggle({ mode = 'lsp_references' }) end },
      { 'gri',       function() require('trouble').toggle({ mode = 'lsp_implementations' }) end },
    },
    cmd = 'Trouble',
  },
  'kosayoda/nvim-lightbulb',
  -- 编辑
  {
    'windwp/nvim-autopairs',
    opts = {
      check_ts = true,
    },
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
    'Shatur/neovim-session-manager',
    config = function()
      local config = require('session_manager.config')
      require('session_manager').setup {
        autoload_mode = config.AutoloadMode.GitSession,
        autosave_ignore_dirs = {},
        autosave_ignore_filetypes = {
          'gitcommit',
          'gitrebase',
        },
        autosave_ignore_buftypes = {},
        autosave_only_in_session = true,
        load_include_current = true,
      }
    end,
    keys = {
      { '<leader>ss', function()
        local config = require('session_manager.config')
        local utils = require('session_manager.utils')
        local Job = require('plenary.job')
        local job = Job:new({
          command = 'git',
          args = { 'rev-parse', '--show-toplevel' },
        })
        job:sync()
        local git_dir = job:result()[1]
        if git_dir then
          utils.save_session(config.dir_to_session_filename(git_dir).filename)
        end
      end },
      { '<leader>sl', function() require('session_manager').load_session() end },
      { '<leader>sd', function() require('session_manager').delete_session() end },
    },
    lazy = false,
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
