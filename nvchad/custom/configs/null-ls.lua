local present, null_ls = pcall(require, "null-ls")
if not present then
  return
end

local b = null_ls.builtins

local sources = {
  -- bash
  b.formatting.shfmt,
  -- python
  b.formatting.black.with { extra_args = { "--fast" } },
  b.formatting.isort,
  b.diagnostics.flake8,
  -- b.formatting.ruff,
  -- b.diagnostics.ruff,
  -- Golang
  b.formatting.gofmt,
  b.formatting.goimports,
  b.formatting.golines,
  b.diagnostics.golangci_lint,
  -- Lua
  b.formatting.stylua,
  b.code_actions.gitsigns,
}

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
