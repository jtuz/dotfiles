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
  theme = "oxocarbon",
  transparency = false,
  hl_override = {
    Comment = { italic=true, fg="grey_fg" },
    -- AlphaHeader = { fg = "red" },
    NvDashAscii= { bg="#0E2738", fg="red" },
    -- NvDashAscii= { bg="black2", fg = "red" },
    NvDashButtons= { bg="#17415E", fg="white" },
  },
  statusline = {
    separator_style = "default", -- default/round/block/arrow
    overriden_modules = function()
      return require "custom.ui.statusline"
    end,
  },
  tabufline = {
    overriden_modules = function()
      return require "custom.ui.tabufline"
    end,
  },
  nvdash = {
    load_on_startup = true,

    header = {
        "⠀⠀⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣿⣿⣿⢿⣿⢿⡿⣟⣿⣟⣿⣶⣶⣤⣀⠀⠀⠀⠀⠀",
        "⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣯⣿⣾⣿⣾⣿⢿⣿⢿⣿⣻⣽⡿⣾⡷⣟⣿⢷⣦⠀⠀⠀",
        "⠀⢠⣾⣿⣿⣿⣿⡿⣿⣾⡉⣟⣉⡿⣷⣿⡿⣿⣻⣿⣽⣟⣿⣯⡿⣟⣿⣻⣽⢿⡄⠀",
        "⢠⣿⣿⣿⣿⣿⡿⣿⣯⣨⣿⣉⣿⢦⢾⡿⣻⣿⢿⣽⣾⣿⣽⣾⢿⣻⣯⣿⣽⣟⣿⡄",
        "⣾⣿⣿⣿⣿⣿⣿⣿⣿⣧⣼⠛⡧⢐⣴⠂⠞⠻⣿⣻⣷⢿⡷⣿⣟⣿⢷⡿⣾⣯⣷⣧",
        "⣿⣿⣿⣿⣿⣿⣿⣻⣽⣿⣯⣏⣬⠈⠁⠁⠀⠀⠉⢿⣻⣿⣻⣯⣿⣽⣟⣿⣻⡾⣷⢿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠙⢽⣿⣽⣾⣯⣿⣽⣯⣿⣻⡿",
        "⣿⣿⣿⣿⣿⣿⣯⣿⣷⣿⣿⣿⣽⣿⣷⣄⠀⠀⠀⠀⠀⠀⠑⢿⣾⢷⡿⣾⢷⣟⣷⢿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣻⣽⣿⣯⣿⡿⠗⠀⠀⠀⠀⠀⠀⣼⣟⣿⣻⣟⣿⣽⣟⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣽⠟⠁⠀⠀⠀⠀⠀⣠⣾⢿⣽⣯⣿⣽⡷⣿⢾⣻",
        "⣿⣿⣿⣿⣿⣿⣯⣿⣿⣟⣯⣷⡟⠧⠀⠀⠀⠀⠀⢀⣴⣿⣻⣟⣿⡾⣷⣟⣿⣽⣟⣿",
        "⢿⣿⣿⣿⣿⣿⣿⡿⣟⣿⡿⣟⢐⣇⢸⣮⣀⡀⣴⣿⢿⣽⣿⣽⣷⢿⣯⡿⣷⣻⣽⡞",
        "⠘⣿⣿⣿⣿⣿⣿⣿⣿⡿⠦⣾⠛⣧⡴⣼⣤⣿⣿⣻⣿⣻⣾⢿⡾⣿⢷⣿⣻⣽⣷⠃",
        "⠀⠘⣿⣿⣿⣿⣷⣿⣿⣷⣾⠛⡾⠛⣤⣿⣯⣿⣾⣿⣽⣿⣽⣿⣻⣟⣿⣽⢿⣞⠃⠀",
        "⠀⠀⠈⠻⢿⣿⣿⣟⣯⣿⣿⣻⣿⣿⡿⣿⣽⣿⡾⣿⡾⣷⣿⢾⣿⣽⢿⡾⠛⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠉⠛⠿⠿⣿⡿⣿⣻⣷⣿⣿⢿⣾⡿⣟⣿⡿⣾⠿⠷⠛⠉⠀⠀⠀⠀⠀",
    },
    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Git Files", "Spc f g", "Telescope git_files" },
      { "  File Tree", "Spc f t", "NvimTreeToggle" },
      { "  Themes", "Spc t h", "Telescope themes" },
    },
  },
}

M.plugins = require "custom.plugins"

-- non plugin mappings
M.mappings = require "custom.mappings"

return M
