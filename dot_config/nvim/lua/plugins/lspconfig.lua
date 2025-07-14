local lspconfig = require("lspconfig")
local lsputil = require("lspconfig.util")
local navic = require("nvim-navic")
local blink = require("blink.cmp")

local runtime_path = vim.split(package.path, ';')
-- 在 lsp-config 解决 issue 前，仍然需要 capabilities
-- https://cmp.saghen.dev/installation#lsp-capabilities
local capabilities = blink.get_lsp_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client then
      if client.server_capabilities.documentSymbolProvider then
        if client.name ~= "volar" then
          navic.attach(client, bufnr)
        end
      end
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable()
      end
    end
  end
})

lspconfig['basedpyright'].setup {
  capabilities = capabilities,
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
      },
    },
  },
}

lspconfig['clangd'].setup {
  capabilities = capabilities,
  cmd = { "clangd", "--pch-storage=memory", "-j=96" },
}

lspconfig['cmake'].setup {
  capabilities = capabilities,
}

lspconfig['djlsp'].setup {
  capabilities = capabilities,
}

lspconfig['gopls'].setup {
  capabilities = capabilities,
}

lspconfig['jinja_lsp'].setup {
  capabilities = capabilities,
}

lspconfig['jsonls'].setup {
  capabilities = capabilities,
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

lspconfig['ruff'].setup {
  capabilities = capabilities,
}

lspconfig['rust_analyzer'].setup {
  capabilities = capabilities,
}

lspconfig['ts_ls'].setup {
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
}

-- sudo npm install -g @vue/typescript-plugin @vue/language-server
lspconfig['volar'].setup {
  capabilities = capabilities,
}

vim.diagnostic.config {
  virtual_text = true,
  -- 输入时不实时提示错误
  update_in_insert = false,
  -- 使用 [d 和 ]d 跳转的时候，仅跳转到错误
  jump = {
    severity = vim.diagnostic.severity.ERROR,
  },
}
