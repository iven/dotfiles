local lspconfig = require("lspconfig")
local lsputil = require("lspconfig.util")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lsp_format = require("lsp-format")
local lsp_inlayhints = require("lsp-inlayhints")
local navic = require("nvim-navic")

local runtime_path = vim.split(package.path, ';')
local capabilities = cmp_nvim_lsp.default_capabilities()
-- https://www.reddit.com/r/neovim/comments/tul8pb/lsp_clangd_warning_multiple_different_client/
local clangd_capabilities = cmp_nvim_lsp.default_capabilities()
clangd_capabilities.offsetEncoding = "utf-8"

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    lsp_format.on_attach(client)
    lsp_inlayhints.on_attach(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
  end
})

lsp_format.setup()
lsp_inlayhints.setup {
  inlay_hints = {
    only_current_line = true,
  },
}

local servers = { 'cmake', 'pyright', 'gopls', 'rust_analyzer', 'tsserver' }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

lspconfig['clangd'].setup {
  capabilities = clangd_capabilities,
  cmd = { "clangd", "--pch-storage=memory", "-j=96" },
}

lspconfig['nil_ls'].setup {
  capabilities = capabilities,
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  },
}

lspconfig['lua_ls'].setup {
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
        -- https://github.com/neovim/nvim-lspconfig/issues/1700
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
}

-- 为 LSP 浮动窗口添加边框
-- https://vi.stackexchange.com/questions/39074/user-borders-around-lsp-floating-windows
local _border = "rounded"

require('lspconfig.ui.windows').default_options = {
  border = _border
}

vim.diagnostic.config {
  -- 输入时不实时提示错误
  update_in_insert = false,
  float = {
    border = _border,
  },
}
