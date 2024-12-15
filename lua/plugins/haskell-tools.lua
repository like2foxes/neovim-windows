return {
	'mrcjkb/haskell-tools.nvim',
	version = '^4', -- Recommended
	lazy = false, -- This plugin is already lazy
	config = function()
		-- ~/.config/nvim/after/ftplugin/haskell.lua
		local ht = require('haskell-tools')
		local bufnr = vim.api.nvim_get_current_buf()
		local opts = { noremap = true, buffer = bufnr, }
		-- haskell-language-server relies heavily on codeLenses,
		-- so auto-refresh (see advanced configuration) is enabled by default
		vim.keymap.set('n', '<leader>tl', vim.lsp.codelens.run, opts)
		-- Hoogle search for the type signature of the definition under the cursor
		vim.keymap.set('n', '<leader>ts', ht.hoogle.hoogle_signature, opts)
		-- Evaluate all code snippets
		vim.keymap.set('n', '<leader>ta', ht.lsp.buf_eval_all, opts)
		-- Toggle a GHCi repl for the current package
		vim.keymap.set('n', '<leader>tp', ht.repl.toggle, opts)
		-- Toggle a GHCi repl for the current buffer
		vim.keymap.set('n', '<leader>tb', function()
			ht.repl.toggle(vim.api.nvim_buf_get_name(0))
		end, opts)
		vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)
	end
}
