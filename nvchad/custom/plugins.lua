local op_sys = require "custom.utils"
local config = require "custom.configs"

return {
  ----------- Overwrite defaults ------------
  {
    "lewis6991/gitsigns.nvim",
    opts = config.gitsigns,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = config.telescope,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = config.nvimtree,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = config.treesitter,
    dependencies = {
      { "yioneko/nvim-yati" },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = config.mason,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = config.blankline,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
      {
        "simrat39/symbols-outline.nvim",
        config = function ()
          require("symbols-outline").setup({
            show_numbers = true,
            show_relative_numbers = true,
          })
        end,
      },
      {
        "SmiteshP/nvim-navic",
        config = function()
          require("nvim-navic").setup()
        end,
      },
      {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        lazy = false,
        opts = {
          -- configurations go here
          show_dirname = false,
          show_basename = false,
          attach_navic = false,
          kinds = require "custom.configs.barbecue"
        },
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "NvChad/nvterm",
    lazy = false,
    config = function ()
      require("nvterm").setup()
      require("custom.configs.nvterm_config")
    end,
  },
  {
    "folke/which-key.nvim",
    enabled = false,
  },
  ------------ Custom plugins ---------------
  {
    "tpope/vim-abolish",
    lazy = false,
  },
  {
    "tpope/vim-repeat",
    lazy = false,
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "tpope/vim-sleuth",
    lazy = false,
  },
  {
    "tommcdo/vim-exchange",
    lazy = false,
  },
  {
    "matze/vim-move",
    lazy = false,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
  },
  {
    "godlygeek/tabular",
    lazy = false,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "chentoast/marks.nvim",
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
  {
    "karb94/neoscroll.nvim",
    lazy = true,
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup()
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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
  {
    "nvim-telescope/telescope-media-files.nvim",
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
  {
    "natecraddock/sessions.nvim",
    lazy = false,
    config = function()
      require("sessions").setup {
        events = { "WinEnter" },
        session_filepath = ".nvim/session",
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = false,
    config = function()
      require("dapui").setup()
      require('dap.ext.vscode').load_launchjs(".nvim/launch.json", nil)
    end,
    dependencies = {
      {
        "mfussenegger/nvim-dap",
        config = function ()
          require("custom.configs.dap_config")
        end
      },
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          local mason_venv_path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
          require("dap-python").setup(mason_venv_path)
        end,
      },
    }
  },
  {
    "folke/noice.nvim",
    lazy = false,
    config = function ()
      require("noice").setup({
        lsp = {
          progress = {
            enabled = false,
          },
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
  -- Local plugins
  -- { dir =  "/mnt/6284C2A984C27ED3/Workspace/opensource/jtuzp/copy-reference/"  },
}
