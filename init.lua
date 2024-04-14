vim.g.mapleader = ' '
vim.keymap.set({'v','i', 'x', 'c'}, 'jk', '<esc>')
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

-- timeout
vim.opt.timeout = true
vim.opt.timeoutlen = 300

vim.opt.clipboard = 'unnamedplus'

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
vim.cmd.colorscheme('tokyonight')
