return {
	'folke/which-key.nvim',
	init = function()
		-- timeout
		vim.opt.timeout = true
		vim.opt.timeoutlen = 200
	end,
	opts = { }
}
