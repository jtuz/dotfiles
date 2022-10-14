-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event','cmd' fields)
-- see: https://github.com/wbthomason/packer.nvim
-- https://nvchad.github.io/config/walkthrough
local op_sys = require "custom.utils"
local overrides = require "custom.plugins.configs"

return {
  ----------- Override defaults ------------
  --
  ["nvim-telescope/telescope.nvim"] = {
    override_options = overrides.telescope,
  },
  ["goolord/alpha-nvim"] = {
    disable = false,
    override_options = overrides.alpha,
  },

  ["kyazdani42/nvim-tree.lua"] = {
    override_options = overrides.nvimtree,
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = overrides.treesitter,
  },
  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason,
  },
  ["lukas-reineke/indent-blankline.nvim"] = {
    override_options = overrides.blankline,
  },
  ["NvChad/ui"] = {
    override_options = {
      statusline = {
        -- default, round , slant , block , arrow
        separator_style = "block",
        overriden_modules = function()
          return require "custom.ui.statusline"
        end,
      },
      tabufline = {
        overriden_modules = function()
          return require "custom.ui.tabufline"
        end,
      }
    },
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["NvChad/nvterm"] = false,
  ["folke/which-key.nvim"] = false,
  ------------ Custom plugins ---------------
  ["tpope/vim-surround"] = {
    keys = { "c", "d", "y" },
  },
  ["tpope/vim-abolish"] = {},
  ["tpope/vim-repeat"] = {},
  ["tpope/vim-fugitive"] = {},
  ["tpope/vim-sleuth"] = {},
  ["tpope/vim-projectionist"] = {},
  ["kshenoy/vim-signature"] = {},
  ["liuchengxu/vista.vim"] = {},
  ["tommcdo/vim-exchange"] = {},
  ["matze/vim-move"] = {},
  ["mg979/vim-visual-multi"] = {
    branch = "master",
  },
  ["godlygeek/tabular"] = {},
  ["editorconfig/editorconfig-vim"] = {},
  ["karb94/neoscroll.nvim"] = {
    opt = true,
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup()
    end,
  },
  ["SmiteshP/nvim-navic"] = {
    requires = "neovim/nvim-lspconfig",
  },
  ["folke/todo-comments.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end,
  },
  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    run = "make",
    after = "telescope.nvim",
    config = function()
      require("telescope").setup {
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }
      require("telescope").load_extension "fzf"
    end,
  },
  ["nvim-telescope/telescope-media-files.nvim"] = {
    disable = op_sys.OSX(),
    after = "telescope.nvim",
    config = function()
      require("telescope").setup {
        extensions = {
          media_files = {
            filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "rg", -- find command (defaults to `fd`)
          },
        },
      }
      require("telescope").load_extension "media_files"
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls").setup()
    end,
  },
  -- macos specific plugin
  ["mrjones2014/dash.nvim"] = {
    disable = op_sys.LINUX(),
    run = "make install",
    after = "telescope.nvim",
  },
  ["natecraddock/sessions.nvim"] = {
    config = function()
      require("sessions").setup {
        events = { "WinEnter" },
        session_filepath = ".nvim/session",
      }
    end,
  },
  -- dim inactive windows
  ["andreadev-it/shade.nvim"] = {
    module = "shade",
    config = function()
      require("custom.plugins.configs").shade()
    end,
  },
}
