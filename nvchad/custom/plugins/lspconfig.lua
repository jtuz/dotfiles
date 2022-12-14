local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local navic = require("nvim-navic")

-- an alternative server could be "pylsp" but for now
-- pyright has a better performance and integration with
-- other tools like null-ls formatter
local servers = { "pyright", "gopls", "bashls", "jsonls"}


for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = function (client, bufnr)
      on_attach(client, bufnr)
      navic.attach(client, bufnr)
    end,
    capabilities = capabilities,
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Disable virtual_text
        virtual_text = false
      }
      ),
    },
    -- root_dir = vim.loop.cwd,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      python = {
        analysis = {
          autoSearchPaths = false,
          useLibraryCodeForTypes = false,
          diagnosticMode = 'openFilesOnly',
        }
      },
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  }
end
-- custom typescript  example
-- lspconfig.tsserver.setup {
--   cmd = { "typescript-language-server", "--stdio" },
--   filetypes = {"typescriptreact", "typescript.tsx"},
--   root_dir = root_pattern("package.json", "tsconfig.json")
-- }
