-- IMPORTANT NOTE : This is the user config, can be edited. Will be preserved if updated with internal updater
-- This file is for NvChad options & tools, custom settings are split between here and 'lua/custom/init.lua'
local highlights = require "custom.ui.highlights"

local M = {}

-- ui configs
M.ui = {
  -- theme to be used, check available themes with `<leader> + t + h`
  theme_toggle = { "gruvchad", "ayu_dark" },
  theme = "ayu_dark",
  transparency = false,
  hl_override = highlights.override,
  hl_add = highlights.add,
  cmp = {
    lspkind_text = false,
    style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
  },
  -- https://github.com/NvChad/NvChad/commit/16fadf9e0d53cf65a954486952ac3eba36d46788#commitcomment-139350293
  statusline = {
    theme = "default",         -- default/vscode/vscode_colored/minimal
    separator_style = "block", -- default/round/block/arrow
    order = { "mode", "customFile", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "customCwd", "customCursorPosition" },
    modules = {
      customFile = function ()
        return require("custom.ui.statusline").FileInfo()
      end,
      customCwd = function ()
        return require("custom.ui.statusline").Cwd()
      end,
      customCursorPosition = function ()
        return require("custom.ui.statusline").CursorPosition()
      end
    }
  },
  tabufline = {
    order = { "treeOffset", "buffers", "tabs" },
    modules = {},
  },
  telescope = {
    style = "borderless", -- borderless / bordered
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
      { "  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Git Files", "Spc f g", "Telescope git_files" },
      { "  File Tree", "Spc f t", "NvimTreeToggle" },
      { "  Themes", "Spc t h", "Telescope themes" },
    },
  },
  lsp = {
    signature = true,
    semantic_tokens = true,
  }
}

M.plugins = "custom.plugins"

M.lazy_nvim = require "custom.configs.lazy_nvim"

-- non plugin mappings
M.mappings = require "custom.mappings"

M.base46 = {
  integrations = {
    "blankline",
    "cmp",
    "defaults",
    "devicons",
    "dap",
    "git",
    "lsp",
    "mason",
    "nvchad_updater",
    "nvcheatsheet",
    "nvdash",
    "nvimtree",
    "statusline",
    "syntax",
    "treesitter",
    "tbline",
    "telescope",
    "whichkey",
  },
}

return M
