vim.g.mapleader = ' '
vim.keymap.set('n', '<esc>', '<cmd>noh<cr>')
vim.keymap.set({'v','i', 'x', 'c', 'n'}, 'jk', '<esc>')
vim.keymap.set('t', 'jk', '<c-\\><c-n>')

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

vim.opt.smartindent = true

vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

vim.opt.inccommand = 'split'

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

-- colors
vim.cmd.colorscheme('gruvbox')

Dotnet = require('dotnet-picker')
