-- vim: ts=4 sw=4 noet ai cindent syntax=lua

-- global
jsonhelper = {}

-- template variables
local color_preset_dark = {
  icon      = '#1e88e5',
  text      = '#78909c',
  separator = '#545454',
  value     = '#ff5722'
}

local color_preset_bright = {
  icon      = '#5c5dad',
  text      = '#606040',
  separator = '#c9c925',
  value     = '#000000'
}

local color_preset = color_preset_dark

function jsonhelper.icon(text, color)
  color = color or color_preset.icon

  return [[  {
    "full_text":"]] .. text .. [[",
    "color":"\]] .. color .. [[",
    "separator":false,
    "separator_block_width":6}
  ]]
end

function jsonhelper.text(text, color)
  color = color or color_preset.text

  return [[  {
    "full_text":"]] .. text .. [[",
    "color":"\]] .. color .. [[",
    "separator":false,
    "separator_block_width":6}
  ]]
end

function jsonhelper.separator(color)
  color = color or color_preset.separator

  return [[  {
	"full_text":"|",
    "color":"\]] .. color .. [[",
    "separator":false,
    "separator_block_width":5}
  ]]
end

function jsonhelper.value(text, color)
  color = color or color_preset.value

  return [[  {
    "full_text":"]] .. text .. [[",
    "color":"\]] .. color .. [[",
    "separator":false,
    "separator_block_width":6}
  ]]
end


function jsonhelper.common(awesome_icon, text, value)
  json = jsonhelper.separator()
  
  if awesome_icon then json = json .. [[,
  ]] ..  jsonhelper.icon(awesome_icon) end
  if text then json = json .. [[,
  ]] .. jsonhelper.text(text) end
  if value then json = json .. [[,
  ]] .. jsonhelper.value(value) end
  
  return json
end
