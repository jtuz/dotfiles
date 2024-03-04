local map = vim.keymap.set

map("n", "<C-s>", "<NOP>")
map("n", "<C-n>", "<NOP>")
map("n", "<C-c>", "<NOP>")
map("n", "<leader>b", "<NOP>")
map("n", "<leader>gt", "<NOP>")
-- Disable NvTerm shortcuts
map("n", "<A-i>", "<NOP>")
map("n", "<A-h>", "<NOP>")
map("n", "<A-v>", "<NOP>")
map("n", "<leader>h", "<NOP>")
map("n", "<leader>v", "<NOP>")
map("t", "<A-i>", "<NOP>")
map("t", "<A-h>", "<NOP>")
map("t", "<A-v>", "<NOP>")

-- Telescope
map("n", "<leader>sy", "<cmd> Telescope lsp_document_symbols<CR>", { desc = "Find document symbols" })
map("n", "<leader>gr", "<cmd> Telescope lsp_references<CR>", { desc = "Find document references" })
map("n", "<leader>dg", "<cmd> Telescope diagnostics<CR>", { desc = " Document diagnostics" })
map("n", "<leader>fg", "<cmd> Telescope git_files<CR>", { desc = "Find git files" })
map("n", "<leader>gs", "<cmd> Telescope git_status<CR>", { desc = "Git status" })
map("n", "<leader>fp", "<cmd> Telescope media_files<CR>", { desc = "Find media" })

-- Nvim tree
map("n", "<leader>ft", "<cmd> NvimTreeToggle <CR>", { desc = "toggle nvimtree" })

-- Spell
map("n", "<F2>", "<Esc><cmd> setlocal spell spelllang=en<CR>", { desc = "ENG spelling" })
map("n", "<F3>", "<Esc><cmd> setlocal spell spelllang=es<CR>", { desc = "ESP spelling" })
map("n", "<F4>", "<Esc><cmd> setlocal nospell<CR>", { desc = "Disable spelling" })

-- fugitive
map("n", "<leader>gb", "<cmd> Git blame <CR>", { desc = "git blame" })
map("n", "<leader>gh", "<cmd> diffget //2 <CR>", { desc = "diffget //2" })
map("n", "<leader>gl", "<cmd> diffget //3 <CR>", { desc = "diffget //3" })

-- Vim Ninja Skills
map("n", "<Up>", "<NOP>", { desc = "Disable Up" })
map("n", "<Down>", "<NOP>", { desc = "Disaple Down" })
map("n", "<Left>", "<NOP>", { desc = "Disable Left" })
map("n", "<Right>", "<NOP>", { desc = "Disable Right" })
-- Personal Tools
map("n", "<leader>jq", "<Esc><cmd>%!jq .<CR><Esc><cmd> set filetype=json<CR>", { desc = "Format Json" })
map("n", "<leader>so", "<cmd> SymbolsOutline<CR>", { desc = "Symbols Outline" })

-- Vim Ninja Skills
map("i", "<Up>", "<NOP>", { desc = "Disable Up" })
map("i", "<Down>", "<NOP>", { desc = "Disable Down" })
map("i", "<Left>", "<NOP>", { desc = "Disable Left" })
map("i", "<Right>", "<NOP>", { desc = "Disable Right" })
-- navigate within insert mode
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- gitsigns
map("n", "<leader>hb", function()
  require("gitsigns").blame_line()
end, { desc = "Blame line" })

-- DAP
map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Start Debbuging" })
map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Step Over", })
map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Step Into" })
map("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "Step Out" })
map("n", "<leader>b", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint", })
map("n", "<leader>B", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Set Breakpoint Condition", })
map("n", "<leader>lp", function()
  require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Log point message", })
map("n", "<leader>repl", function()
  require("dap").repl.open()
end, { desc = "Open REPL", })
map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle DAP GUI", })
map("n", "<leader>vl", function()
  require("dapui").eval()
end, { desc = "Evaluate expression", })
