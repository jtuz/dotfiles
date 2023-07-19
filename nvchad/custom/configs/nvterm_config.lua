local terminal = require("nvterm.terminal")

local toggle_modes = { "n", "t" }
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>ts", function()
	local ft_cmds = {
		python = "make testnm ARG=" .. vim.fn.expand("%"),
	}
	terminal.send(ft_cmds[vim.bo.filetype])
end, opts)
vim.keymap.set(toggle_modes, "<leader>tf", function()
	terminal.toggle("float")
end, opts)
vim.keymap.set(toggle_modes, "<leader>tv", function()
	terminal.toggle("vertical")
end, opts)
vim.keymap.set(toggle_modes, "<leader>tz", function()
	terminal.toggle("horizontal")
end, opts)
