-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event','cmd' fields)
-- see: https://github.com/wbthomason/packer.nvim
-- https://nvchad.github.io/config/walkthrough
local op_sys = require "custom.utils"
local overrides = require "custom.plugins.configs"
local test = require

return {
  ----------- Override defaults ------------
  --
  ["nvim-telescope/telescope.nvim"] = {
    override_options = overrides.telescope,
  },
  ["goolord/alpha-nvim"] = {
    disable = true,
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
  -- ["NvChad/ui"] = {
  --   override_options = {
  --     statusline = {
  --       -- default, round , slant , block , arrow
  --       separator_style = "default",
  --       overriden_modules = function()
  --         return require "custom.ui.statusline"
  --       end,
  --     },
  --     tabufline = {
  --       overriden_modules = function()
  --         return require "custom.ui.tabufline"
  --       end,
  --     },
  --   },
  -- },
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
  ["yioneko/nvim-yati"] = {
    tag = "*",
    requires = "nvim-treesitter/nvim-treesitter",
    after = "nvim-treesitter",
  },
  ["rcarriga/nvim-dap-ui"] = {
    requires = "mfussenegger/nvim-dap",
    config = function()
      require("dapui").setup()
    end,
  },
  ["mfussenegger/nvim-dap-python"] = {
    requires = "rcarriga/nvim-dap-ui",
    config = function()
      local mason_venv_path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(mason_venv_path)
    end,
  },
  ["folke/noice.nvim"] = {
    config = function ()
      require("noice").setup({
        lsp = {
          hover = {
            enabled = false,
          },
          signature = {
            enabled = false,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        markdown = {
          hover = {
            ["|(%S-)|"] = vim.cmd.help, -- vim help links
            ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
          },
          highlights = {
            ["|%S-|"] = "@text.reference",
            ["@%S+"] = "@parameter",
            ["^%s*(Parameters:)"] = "@text.title",
            ["^%s*(Return:)"] = "@text.title",
            ["^%s*(See also:)"] = "@text.title",
            ["{%S-}"] = "@parameter",
          },
        },
      })
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  }
}
