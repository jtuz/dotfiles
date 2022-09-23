local modules = require "nvchad_ui.statusline.modules"

local navic = function ()
  if vim.o.columns < 140 or not package.loaded["nvim-navic"] then
      return ""
  end
  local navic = require("nvim-navic")
  return (navic.is_available() and navic.get_location()) or ""
end

return {
    LSP_progress = function()
      return modules.LSP_progress() .. navic()
    end,
}
