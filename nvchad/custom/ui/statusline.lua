local modules = require("nvchad_ui.statusline.default")
local config = require("core.utils").load_config().ui.statusline
local sep_style = config.separator_style

local default_sep_icons = {
  default = { left = "", right = " " },
  round = { left = "", right = "" },
  block = { left = "█", right = "█" },
  arrow = { left = "", right = "" },
}

local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]

local sep_l = separators["left"]

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
    cursor_position = function()
      local left_sep = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon#" .. " "
      local text = vim.o.columns > 140 and "%l:%c" or ""
      return left_sep .. "%#St_Pos_txt# " .. text .. " "
    end
}
