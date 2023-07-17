local terminal = require("nvterm.terminal")
local toggle_modes = {"n", "t"}

local function get_command()
  local current_file = vim.fn.expand('%:.')
  return "make testnm ARG="..current_file
end

local ft_cmds = {
  python = get_command()
}


local mappings = {
  { "n", "<leader>ts", function () terminal.send(ft_cmds[vim.bo.filetype], "float") end },
  { toggle_modes, "<leader>tf", function () terminal.toggle("float") end },
  { toggle_modes, "<leader>tv", function () terminal.toggle("vertical") end },
  { toggle_modes, "<leader>tz", function () terminal.toggle("horizontal") end },
}

local opts = { noremap = true, silent=true }
for _, mapping in pairs(mappings) do
  vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
end
