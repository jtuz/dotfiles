local op_sys = require "custom.utils"
local overrides = require "custom.plugins.configs"

return {
  ----------- Override defaults ------------
  ["nvim-telescope/telescope.nvim"] = {
    override_options = overrides.telescope,
  },
  ["nvim-tree/nvim-tree.lua"] = {
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
    lazy = false,
    -- keys = { "c", "d", "y" },
  },
  ["tpope/vim-abolish"] = {
    lazy = false,
  },
  ["tpope/vim-repeat"] = {
    lazy = false,
  },
  ["tpope/vim-fugitive"] = {
    lazy = false,
  },
  ["tpope/vim-sleuth"] = {
    lazy = false,
  },
  ["chentoast/marks.nvim"] = {
    lazy = false,
    config = function ()
      require("marks").setup(
        {
          builtin_marks = { ".", "<", ">", "^" },
          mappings = {
            next = "]'",
            prev = "['",
            delete_buf = "m<space>",
          }
        }
      )
    end
  },
  ["liuchengxu/vista.vim"] = {
    lazy = false,
  },
  ["tommcdo/vim-exchange"] = {
    lazy = false,
  },
  ["matze/vim-move"] = {
    lazy = false,
  },
  ["mg979/vim-visual-multi"] = {
    branch = "master",
    lazy = false,
  },
  ["godlygeek/tabular"] = {
    lazy = false,
  },
  ["editorconfig/editorconfig-vim"] = {
    lazy = false,
  },
  ["karb94/neoscroll.nvim"] = {
    lazy = true,
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup()
    end,
  },
  ["SmiteshP/nvim-navic"] = {
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
  },
  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    build = "make",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
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
    enabled = op_sys.LINUX(),
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
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
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
    lazy = false,
    config = function()
      require("custom.plugins.null-ls").setup()
    end,
  },
  ["natecraddock/sessions.nvim"] = {
    lazy = false,
    config = function()
      require("sessions").setup {
        events = { "WinEnter" },
        session_filepath = ".nvim/session",
      }
    end,
  },
  ["yioneko/nvim-yati"] = {
    version = "*",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  ["rcarriga/nvim-dap-ui"] = {
    dependencies = {
      { "mfussenegger/nvim-dap" },
    },
    config = function()
      require("dapui").setup()
    end,
  },
  ["mfussenegger/nvim-dap-python"] = {
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
    },
    config = function()
      local mason_venv_path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(mason_venv_path)
    end,
  },
  ["folke/noice.nvim"] = {
    lazy = false,
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
    dependencies = {
      {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
    }
  },
  ["simrat39/symbols-outline.nvim"] = {
    lazy = false,
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
    config = function ()
      require("symbols-outline").setup({
        show_numbers = true,
        show_relative_numbers = true,
      })
    end
  }
}
