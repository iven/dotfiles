local telescope = require('telescope')
local actions = require('telescope.actions')
local trouble = require("trouble.sources.telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-d>'] = false,
        ['<C-u>'] = false,
        ['<esc>'] = actions.close,
        ['<C-o>'] = trouble.open,
      },
    },
    sorting_strategy = 'ascending',
    layout_strategy = 'center',
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    },
    undo = {
      vim_diff_opts = {
        ctxlen = 3,
      },
      mappings = {
        i = {
          ["<cr>"] = require("telescope-undo.actions").restore,
        },
        n = {
          ["u"] = require("telescope-undo.actions").restore,
        },
      },
    },
  }
}
telescope.load_extension('fzy_native')
telescope.load_extension('ui-select')
telescope.load_extension('undo')
