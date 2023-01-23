local modules = require("nvchad_ui.statusline.default")
local config = require("core.utils").load_config().ui.statusline
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

local navic = function ()
  if vim.o.columns < 140 or not package.loaded["nvim-navic"] then
      return ""
  end
  local navic = require("nvim-navic")
  return (navic.is_available() and navic.get_location()) or ""
end

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
  return "%#St_file_info#" .. " 暈" .. spelllang .. "%#St_file_sep#" .. sep_r
end

return {
    fileInfo = function ()
      return modules.fileInfo() .. lang_translation()
    end,
    LSP_progress = function()
      return modules.LSP_progress() .. navic()
    end,
    cwd = function ()
      return modules.cwd() .. "" .. platform() .. " "
    end,
    cursor_position = function()
      local left_sep = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon#" .. " "
      local text = vim.o.columns > 140 and "%l:%c" or ""
      return left_sep .. "%#St_Pos_txt# " .. text .. " "
    end,
}
