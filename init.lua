-- leader
vim.keymap.set("n", '<Space>', '<NOP>')
vim.g.mapleader = " "

-- remove highlight
vim.keymap.set('n', '<esc>', '<cmd>noh<cr>')

-- quickfix
vim.keymap.set({ 'n', 'v' }, ']q', '<cmd>cnext<cr>', { desc = 'Next [Q]list Item' })
vim.keymap.set({ 'n', 'v' }, '[q', '<cmd>cprevious<cr>', { desc = 'Previous [Q]list Item' })

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tab size
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- wrap
vim.opt.wrap = false

-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- swap file
vim.opt.swapfile = false

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
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

vim.opt.smartindent = false

vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

vim.opt.inccommand = 'split'

vim.opt.termguicolors = true

vim.cmd.colorscheme('habamax')

if vim.fn.has("win64") == 1 then
	vim.opt.shell        = "pwsh"
	vim.opt.shellxquote  = ""
	vim.opt.shellquote   = ""
	vim.opt.shellcmdflag =
	"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
	vim.opt.shellredir   = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
	vim.opt.shellpipe    = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
end

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
