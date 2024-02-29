local modules = require("nvchad.statusline.default")
local config = require("nvconfig").ui.statusline
local op_sys = require("custom.utils")
local sep_style = config.separator_style

local default_sep_icons = {
  default = { left = "", right = " " },
  round = { left = "", right = "" },
  block = { left = "█", right = "█" },
  arrow = { left = "", right = "" },
}

local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]

local sep_l = separators["left"]
local sep_r = separators["right"]

local platform = function ()
  local os_icon = ""
  if op_sys.LINUX() then
    os_icon = ""
  elseif op_sys.OSX() then
    os_icon = " " -- Note: the previous space is needed in Macos platform
  end

  return  "%#St_cwd_text#" .. os_icon
end

local lang_translation = function ()
  local spell = vim.api.nvim_get_option_value("spell", {})
  local spelllang = vim.api.nvim_get_option_value("spelllang", {})

  if not spell then
    return ""
  end
  return "%#St_file_info#" .. "󰇝 󰓆" .. spelllang .. "%#St_file_sep#" .. sep_r
end

local M = {}

M.fileInfo = function ()
  return modules.fileInfo() .. lang_translation()
end

M.cwd = function ()
  return modules.cwd() .. "󰇝" .. platform() .. " "
end

M.cursor_position = function()
  local left_sep = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon#" .. " "
  local text = vim.o.columns > 140 and "%l:%c" or ""
  return left_sep .. "%#St_Pos_txt# " .. text .. " "
end

return M
