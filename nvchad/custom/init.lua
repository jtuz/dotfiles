local g = vim.g
local opt = vim.opt

local autocmd = vim.api.nvim_create_autocmd
require('dap.ext.vscode').load_launchjs(".nvim/launch.json", nil)

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
-- require('dap-python').test_runner = 'pytest'

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

----------------Plugins Settings----------------
-- Editorconfig
g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*", "fzf://.*" }
g.EditorConfig_max_line_indicator = "line"

-- Vim Move by matze
g.move_key_modifier = "A"
g.move_key_modifier_visualmode = "A"
-- Vista
g.vista_default_executive = "ctags"

----------------Custom Settings----------------
g.markdown_fenced_languages = { "html", "python", "ruby", "vim", "bash" }
-- opt.cmdheight = 0
opt.shiftround = true
opt.encoding = "utf-8"
opt.backspace = "indent,eol,start"
opt.inccommand = "nosplit"
opt.wrap = false -- Do not wrap long lines
opt.list = true
opt.listchars = { eol = "↲", tab = "» ", trail = "·", extends = "▸", nbsp = "." }
opt.autoindent = true

-- Override NvChad default settings
opt.relativenumber = true
opt.tabstop = 4


-------------------- Auto commands -----------------------
-- Instead of reverting the cursor to the last position in the buffer
-- we set it to the first line when editing a git commit message
-- also Editor Config plugin is disabled on git commit message
local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

autocmd("FileType", {
  pattern = "gitcommit",
  group = group,
  callback = function()
    vim.b.EditorConfig_disable = 1
    vim.cmd [[ call setpos('.', [0, 1, 1, 0]) ]]
  end,
})

autocmd("BufEnter", {
  pattern = "COMMIT_EDITMSG",
  group = group,
  callback = function()
    vim.b.EditorConfig_disable = 1
    vim.cmd [[ call setpos('.', [0, 1, 1, 0]) ]]
  end,
})

-- Open a file from its last left off position
autocmd("BufReadPost", {
   callback = function()
      if not vim.fn.expand("%:p"):match ".git" and vim.fn.line "'\"" > 1 and vim.fn.line "'\"" <= vim.fn.line "$" then
         vim.cmd "normal! g'\""
         vim.cmd "normal zz"
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

autocmd('FileType', {
  pattern = {'help', 'man'},
  command = 'nnoremap <buffer> gq <cmd>quit<cr>'
})
