-- leader
vim.keymap.set("n", '<Space>', '<NOP>')
vim.g.mapleader = " "

-- remove highlight
vim.keymap.set('n', '<esc>', '<cmd>noh<cr>')

-- quickfix
vim.keymap.set('n', '<leader>qq', '<cmd>copen<cr>', {desc = "Open [Q]uicklist"})
vim.keymap.set({ 'n', 'v' }, ']q', '<cmd>cnext<cr>', { desc = 'Next [Q]list Item' })
vim.keymap.set({ 'n', 'v' }, '[q', '<cmd>cprevious<cr>', { desc = 'Previous [Q]list Item' })

vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

vim.keymap.set("n", "<leader>o", "o<esc>k", { desc = "Enter empty line below" })
vim.keymap.set("n", "<leader>O", "O<esc>j", { desc = "Enter empty line above" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tab size
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true

-- wrap
vim.opt.wrap = false

-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = 'screen'

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- swap file
vim.opt.swapfile = false

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldenable = false

-- path
vim.opt.path:append '**'

-- clipboard
vim.opt.clipboard = 'unnamedplus'

-- menu
vim.opt.completeopt = 'menu,menuone,noselect'

-- cursor
vim.opt.cursorline = true

-- grep using rg
vim.opt.grepprg = "rg --vimgrep"
vim.opt.signcolumn = 'yes'
vim.opt.autoread = true

-- scrolloff
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8

vim.opt.smartindent = true

vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

vim.opt.inccommand = 'split'

vim.opt.termguicolors = true

vim.opt.list = true

vim.opt.undofile = true

vim.opt.virtualedit = 'block'

vim.opt.wildmode = "longest:full,full"

vim.opt.winminwidth = 5

vim.opt.smoothscroll = true


if vim.fn.has("win64") == 1 then
	vim.opt.shell        = "pwsh"
	vim.opt.shellxquote  = ""
	vim.opt.shellquote   = ""
	vim.opt.shellcmdflag =
	"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
	vim.opt.shellredir   = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
	vim.opt.shellpipe    = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {clear = true}),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3

vim.opt.grepprg = 'rg --vimgrep'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup('plugins')
vim.cmd.colorscheme('kanagawa')
