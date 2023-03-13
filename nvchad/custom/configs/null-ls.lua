local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {
  -- python
  b.formatting.black.with { extra_args = { "--fast" } },
  b.formatting.isort,
  b.diagnostics.flake8,
  -- Golang
  b.formatting.gofmt,
  b.formatting.goimports,
  -- Lua
  b.formatting.stylua,
  b.code_actions.gitsigns,
}

local M = {}

null_ls.setup {
  debug = true,
  sources = sources,

  -- format on save
  -- on_attach = function(client)
  --   if client.resolved_capabilities.document_formatting then
  --     vim.cmd "autocmd BufWritePre <buffer> vim.lsp.buf.formatting_sync()"
  --   end
  -- end,
}
