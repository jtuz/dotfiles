local M = {}

M.gitsigns = {
  signs = {
    add = { text = "" },
    change = { text = "" },
    delete = { text = "󰍵" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "│" },
  },
}

M.nvimtree = {
  sync_root_with_cwd = false,
  git = {
    enable = true,
  },
  view = {
    side = "left",
    width = 45,
    relativenumber = true,
  },
  renderer = {
    root_folder_label = function (path)
      return " " .. vim.fn.fnamemodify(path, ":t")
    end,
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.treesitter = {
  yati = {
    enable = true,
    default_fallback = "auto"
  },
  indent = {
    enable = false,
  },
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "css",
    "dockerfile",
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "haskell",
    "html",
    "htmldjango",
    "javascript",
    "json",
    "jsonc",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "nix",
    "python",
    "regex",
    "ruby",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
}

M.blankline = {
  indent = { char = "┊", highlight = "IblChar" },
  scope = { char = "│", highlight = "IblScopeChar" },
}

M.mason = {
  ensure_installed = {
    "shfmt",
    -- Markdown
    "marksman",
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev
    "json-lsp",
    "html-lsp",

    -- shell
    "bash-language-server",

    -- python
    "pyright",
    "flake8",
    "isort",
    "black",
    "debugpy",
    "ruff",

    -- Golang
    "gopls",
    "goimports",
    "golines",
    "delve",
    "golangci-lint",

    -- xml
    "lemminx",
    "powershell-editor-services",

    -- yaml
    "yaml-language-server",
  },
}

M.telescope = {
 defaults = {
    preview = {
      timeout = 750,
    },
    layout_strategy = "vertical",
    layout_config = {
         horizontal = {
            prompt_position = "bottom",
            preview_width = 0.55,
            results_width = 0.8,
         },
         vertical = {
            mirror = true,
            prompt_position = "top",
            width = 0.7,
            height = 0.95,
            preview_height = 0.6,
            preview_cutoff = 40,
         },
    },
  }
}

return M
