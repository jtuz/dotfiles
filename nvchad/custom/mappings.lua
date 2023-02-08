local M = {}

M.disabled = {
  n = {
    ["<C-s>"] = "",
    ["<C-n>"] = "",
    ["<C-c>"] = "",
    ["<leader>b"] = "",
    ["<leader>gt"] = "",
    -- Disable NvTerm shortcuts
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
    ["<leader>h"] = "",
    ["<leader>v"] = "",
  },
  t = {
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
  }
}

M.telescope = {
  n = {
    ["<leader>sy"] = { "<cmd> Telescope lsp_document_symbols<CR>", "Find document symbols" },
    ["<leader>gr"] = { "<cmd> Telescope lsp_references<CR>","Find document references" },
    ["<leader>dg"] = { "<cmd> Telescope diagnostics<CR>","Document diagnostics" },
    ["<leader>fg"] = { "<cmd> Telescope git_files<CR>", "Find git files" },
    ["<leader>gs"] = { "<cmd> Telescope git_status<CR>", "Git status" },
    ["<leader>fp"] = { "<cmd> Telescope media_files<CR>", "Find media" },
    ["<leader>mk"] = { "<cmd> Telescope marks<CR>",  "Marks" },
  },
}

M.nvimtree = {
   n = {
    ["<leader>ft"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
   },
}

M.spelling = {
  n = {
    ["<F2>"] = { "<Esc><cmd> setlocal spell spelllang=en<CR>", "ENG spelling" },
    ["<F3>"] = { "<Esc><cmd> setlocal spell spelllang=es<CR>", "ESP spelling" },
    ["<F4>"] = { "<Esc><cmd> setlocal nospell<CR>", "Disable spelling" },
  },
}

M.fugitive = {
  n = {
    ["<leader>gb"] = { "<cmd> Git blame <CR>", "git blame" },
    ["<leader>gh"] = { "<cmd> diffget //2 <CR>", "diffget //2" },
    ["<leader>gl"] = { "<cmd> diffget //3 <CR>", "diffget //3" },
  },
}

M.misc = {
  n = {
    -- Vim Ninja Skills
    ["<Up>"] = { "<NOP>", "Disable Up" },
    ["<Down>"] = { "<NOP>", "Disaple Down" },
    ["<Left>"] = { "<NOP>", "Disable Left" },
    ["<Right>"] = { "<NOP>", "Disable Right" },
    -- Personal Tools
    ["<leader>jq"] = { "<Esc>:%!jq .<CR><Esc><cmd> set filetype=json<CR>", "Format Json" },
    ["<leader>so"] = { "<cmd> SymbolsOutline<CR>", "Symbols Outline" }
  },

  i = {
    -- Vim Ninja Skills
    ["<Up>"] = { "<NOP>", "Disable Up" },
    ["<Down>"] = { "<NOP>", "Disable Down" },
    ["<Left>"] = { "<NOP>", "Disable Left" },
    ["<Right>"] = { "<NOP>", "Disable Right" },
    -- navigate within insert mode                                                                              │    │
    ["<C-h>"] = { "<Left>", "move left" },
    ["<C-l>"] = { "<Right>", "move right" },
    ["<C-j>"] = { "<Down>", "move down" },
    ["<C-k>"] = { "<Up>", "move up" },
  },

  v = {
    -- Visual shifting (does not exit visual mode)
    [">"] = { ">gv", "Does not exit visual mode" },
    ["<"] = { "<gv", "Does not exit visual mode" },
  },
}

M.gitsigns = {
  n= {
    ["<leader>hb"] = {
      function()
        require("gitsigns").blame_line()
      end,
      "Blame line",
    },
  },
}

M.dap = {
  n = {
    ["<F5>"] = {
      function()
        require("dap").continue()
      end,
      "Start Debbuging"
    },
    ["<F10>"] = {
      function()
        require("dap").step_over()
      end,
      "Step Over",
    },
    ["<F11>"] = {
      function()
        require("dap").step_into()
      end,
      "Step Into"
    },
    ["<F12>"] = {
      function()
        require("dap").step_out()
      end,
      "Step Out"
    },
    ["<leader>b"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "Toggle Breakpoint",
    },
    ["<leader>B"] = {
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      "Set Breakpoint Condition",
    },
    ["<leader>lp"] = {
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end,
      "Log point message",
    },
    ["<leader>repl"] = {
      function()
        require("dap").repl.open()
      end,
      "Open REPL",
    },
    ["<leader>du"] = {
      function()
        require("dapui").toggle()
      end,
      "Toggle DAP GUI",
    },
    ["<leader>vl"] = {
      function()
        require("dapui").eval()
      end,
      "Evaluate expression",
    },
  }
}

return M
