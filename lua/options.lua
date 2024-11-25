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

FoldText = function(args)
	local foldstart = table.concat(vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1, vim.v.foldstart, true))
	if string.gsub(foldstart, '^%s*(.-)%s*$', '%1') == '{' then
		foldstart = table.concat(vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 2, vim.v.foldstart - 1, true))
	end
	local foldlevel = ""
	for _ = 1, vim.v.foldlevel do
		foldlevel = foldlevel .. vim.v.folddashes
	end
	return foldlevel .. foldstart:gsub('^%s*(.-)%s*$', '%1') .. " Lines: " .. vim.v.foldend - vim.v.foldstart + 1
end
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.FoldText()"
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

vim.opt.ruler = false

vim.opt.showmode = false
vim.opt.laststatus = 3

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
