local g = vim.g
local opt = vim.opt
local cmd = vim.cmd

local autocmd = vim.api.nvim_create_autocmd

----------------Nvim providers----------------
-- Due I use pyenv and rbenv, to avoid
-- install nvim modules for each virtualenv,
-- I declare a global prodiver for neovim

-- Python
g.python3_host_prog = "/usr/bin/python3"
-- Ruby
g.ruby_host_prog = "/usr/bin/ruby"
--
-- Disable providers we do not give a shit about
g.loaded_perl_provider = 0

-- Vim Move by matze
g.move_key_modifier = "A"
g.move_key_modifier_visualmode = "A"

----------------Custom Settings----------------
g.markdown_fenced_languages = { "html", "python", "ruby", "vim", "bash", "go", "lua" }
opt.cmdheight = 0
opt.shiftround = true
opt.encoding = "utf-8"
opt.backspace = "indent,eol,start"
opt.inccommand = "nosplit"
opt.wrap = false -- Do not wrap long lines
opt.list = true
opt.listchars = { eol = "↲", tab = "» ", trail = "·", extends = "▸", nbsp = "." }
opt.diffopt = { "internal", "filler", "closeoff", "linematch:60" }
opt.autoindent = true
opt.colorcolumn = "+1"
opt.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"

-- Override NvChad default settings
opt.relativenumber = true
opt.tabstop = 4

-- Abbrev
cmd("cnoreabbrev Q  q")
cmd("cnoreabbrev q1  q!")
cmd("cnoreabbrev Q1  q!")
cmd("cnoreabbrev Qa1 qa!")
cmd("cnoreabbrev Qa qa")
cmd("cnoreabbrev W  w")
cmd("cnoreabbrev Wq wq")
cmd("cnoreabbrev WQ wq")
cmd("cnoreabbrev Set set")
cmd("cnoreabbrev SEt set")
cmd("cnoreabbrev SET set")

-------------------- Auto commands -----------------------
-- Instead of reverting the cursor to the last position in the buffer
-- we set it to the first line when editing a git commit message
-- also Editor Config plugin is disabled on git commit message
local commit_group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

autocmd("FileType", {
  pattern = "gitcommit",
  group = commit_group,
  callback = function()
    vim.b.editorconfig = false
    vim.cmd [[ call setpos('.', [0, 1, 1, 0]) ]]
  end,
})

autocmd("BufEnter", {
  pattern = "COMMIT_EDITMSG",
  group = commit_group,
  callback = function()
    vim.b.editorconfig = false
    vim.cmd [[ call setpos('.', [0, 1, 1, 0]) ]]
  end,
})

-- Go to last location when opening a buffer
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- File extension specific tabbing
autocmd("Filetype", {
   pattern = "python",
   callback = function()
      vim.opt_local.foldlevel = 9
      vim.opt_local.foldmethod = "indent"
      vim.opt_local.expandtab = true
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.softtabstop = 4
   end,
})

-- Highlight yanked text
autocmd("TextYankPost", {
   callback = function()
      vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
   end,
})

-- Enable spellchecking in markdown, text and gitcommit files
autocmd("FileType", {
   pattern = { "gitcommit", "markdown", "text" },
   callback = function()
      vim.opt_local.spell = true
   end,
})

autocmd("FileType", {
  pattern = {"help", "man"},
  command = "nnoremap <buffer> gq <cmd>quit<cr>"
})

-- Fix conceallevel for json files
autocmd("FileType", {
  pattern = {"json", "jsonc"},
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})
