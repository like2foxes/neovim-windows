return {
	'nvimdev/lspsaga.nvim',
	event = 'LspAttach',
	config = function()
		require('lspsaga').setup({})
		require('lspsaga.symbol.winbar').get_bar()
		vim.keymap.set({ 'n', 't' }, '<leader>[', '<cmd>Lspsaga term_toggle<cr>', { desc = 'Toggle Terminal' })
		vim.keymap.set('n', '<leader>k', '<cmd>Lspsaga peek_definition<cr>', { desc = 'Peek Definition' })
		vim.keymap.set('n', '<leader>l', '<cmd>Lspsaga finder<cr>', { desc = 'Lsp Finder' })
		vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', { desc = 'Hover' })
		vim.keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<cr>', { desc = 'Outline'})
	end,
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
		'nvim-tree/nvim-web-devicons'
	}
}
