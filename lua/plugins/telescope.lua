return {
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local t = require('telescope.builtin');
		local find_git_files_or_all = function()
			local ok, _ = pcall(t.git_files)
			if not ok then
				t.find_files()
			end
		end

		vim.keymap.set('n', '<leader>T', ':Telescope ', { desc = '[T]elescope' })
		vim.keymap.set('n', '<leader> ', t.buffers, { desc = 'Buffers' })
		vim.keymap.set('n', '<leader>/', t.current_buffer_fuzzy_find, { desc = 'Search Buffer' })
		vim.keymap.set('n', '<leader>f', find_git_files_or_all, { desc = '[F]iles' })
		vim.keymap.set('n', '<leader>F', t.find_files, { desc = 'All [F]iles' })
		vim.keymap.set('n', '<leader>g', t.live_grep, { desc = 'Live [G]rep' })
		vim.keymap.set('n', '<leader>G', t.grep_string, { desc = '[G]rep string' })
		vim.keymap.set('n', '<leader>s', t.lsp_document_symbols, { desc = 'Document [S]ymbols' })
		vim.keymap.set('n', '<leader>S', t.lsp_workspace_symbols, { desc = 'Workspace [S]ymbols' })
		vim.keymap.set('n', '<leader>D', t.diagnostics, { desc = '[D]iagnostics' })
		vim.keymap.set('n', '<leader>H', t.help_tags, { desc = '[H]elp tags' })
	end
}
