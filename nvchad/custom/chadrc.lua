-- IMPORTANT NOTE : This is the user config, can be edited. Will be preserved if updated with internal updater
-- This file is for NvChad options & tools, custom settings are split between here and 'lua/custom/init.lua'

local M = {}

M.options = {
  -- NvChad options
  nvChad = {
    -- used for updater
    update_url = "https://github.com/jtuz/NvChad",
    update_branch = "main",
  },
}

-- ui configs
M.ui = {
  -- theme to be used, check available themes with `<leader> + t + h`
  theme_toggle = { "gruvchad", "tokyonight" },
  theme = "oceanic-next",
  transparency = false,
  hl_override = {
    Comment = { italic = true, fg="grey_fg" },
    AlphaHeader = { fg = "red" },
  },
}

M.plugins = require "custom.plugins"

-- non plugin mappings
M.mappings = require "custom.mappings"

return M
