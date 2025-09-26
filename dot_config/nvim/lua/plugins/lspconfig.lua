local navic = require("nvim-navic")
local lsputil = require("lspconfig.util")

local runtime_path = vim.split(package.path, ';')
local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client then
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable()
      end
    end
  end
})

vim.lsp.config('basedpyright', {
  capabilities = capabilities,
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
      },
    },
  },
})
vim.lsp.enable('basedpyright')

vim.lsp.config('clangd', {
  capabilities = capabilities,
  cmd = { "clangd", "--pch-storage=memory", "-j=96" },
})
vim.lsp.enable('clangd')

vim.lsp.config('cmake', { capabilities = capabilities })
vim.lsp.enable('cmake')

vim.lsp.config('djlsp', { capabilities = capabilities })
vim.lsp.enable('djlsp')

vim.lsp.config('gopls', { capabilities = capabilities })
vim.lsp.enable('gopls')

vim.lsp.config('jinja_lsp', { capabilities = capabilities })
vim.lsp.enable('jinja_lsp')

vim.lsp.config('jsonls', {
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})
vim.lsp.enable('jsonls')

vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        -- https://github.com/neovim/nvim-vim.lsp.config/issues/1700
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  root_dir = lsputil.root_pattern(
    "init.lua",
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git"
  ),
})
vim.lsp.enable('lua_ls')

vim.lsp.config('nil_ls', {
  capabilities = capabilities,
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  },
})
vim.lsp.enable('nil_ls')

vim.lsp.config('ruff', { capabilities = capabilities })
vim.lsp.enable('ruff')

vim.lsp.config('rust_analyzer', { capabilities = capabilities })
vim.lsp.enable('rust_analyzer')

vim.lsp.config('ts_ls', {
  capabilities = capabilities,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/lib/node_modules/@vue/typescript-plugin",
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
})
vim.lsp.enable('ts_ls')

vim.lsp.config('yamlls', {
  capabilities = capabilities,
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
})
vim.lsp.enable('yamlls')

vim.diagnostic.config {
  virtual_text = true,
  -- 输入时不实时提示错误
  update_in_insert = false,
  -- 使用 [d 和 ]d 跳转的时候，仅跳转到错误
  jump = {
    severity = vim.diagnostic.severity.ERROR,
  },
}
