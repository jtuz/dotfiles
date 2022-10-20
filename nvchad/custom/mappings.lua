local M = {}

M.disabled = {
  n = {
    ["<C-s>"] = "",
    ["<C-n>"] = "",
    ["<C-c>"] = "",
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
    ["<leader>sy"] = { "<cmd> Telescope lsp_document_symbols<CR>", "  find document symbols" },
    ["<leader>gr"] = { "<cmd> Telescope lsp_references<CR>","  find document references" },
    ["<leader>dg"] = { "<cmd> Telescope diagnostics<CR>","  document diagnostics" },
    ["<leader>fg"] = { "<cmd> Telescope git_files<CR>", "  find git files" },
    ["<leader>gs"] = { "<cmd> Telescope git_status<CR>", "  git status" },
    ["<leader>fp"] = { "<cmd> Telescope media_files<CR>", "  find media" },
    ["<leader>mk"] = { "<cmd> Telescope marks<CR>",  "車 Marks" },
    ["<leader>tl"] = { "<cmd> TodoTelescope<CR>",  "  Todo Telescope" },
  },
}

M.nvimtree = {
   n = {
    -- toggle
    ["<leader>ft"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },
   },
}

M.spelling = {
  n = {
    ["<F6>"] = { "<Esc><cmd> setlocal spell spelllang=es<CR>", "暈  ESP spelling" },
    ["<F7>"] = { "<Esc><cmd> setlocal spell spelllang=en<CR>", "暈  ENG spelling" },
    ["<F8>"] = { "<Esc><cmd> setlocal nospell<CR>", "Disable spelling" },
  },
}

M.fugitive = {
  n = {
    ["<leader>gb"] = { "<cmd> Git blame <CR>", "  git blame" },
    ["<leader>gh"] = { "<cmd> diffget //2 <CR>", "  diffget //2" },
    ["<leader>gl"] = { "<cmd> diffget //3 <CR>", "  diffget //3" },
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
    ["<leader>jt"] = { "<Esc>:%!jq .<CR><Esc><cmd> set filetype=json<CR>", "  Format Json" },
  },

  i = {
    -- Vim Ninja Skills
    ["<Up>"] = { "<NOP>", "Disable Up" },
    ["<Down>"] = { "<NOP>", "Disable Down" },
    ["<Left>"] = { "<NOP>", "Disable Left" },
    ["<Right>"] = { "<NOP>", "Disable Right" },
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

M.shade = {
  n = {
    ["<leader>ts"] = {
      function()
        require("shade").toggle()
      end,

      "toggle shade.nvim",
    },
  },
}

return M
