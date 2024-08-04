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

		local trouble = require("trouble.sources.telescope")
		local telescope = require("telescope")

		telescope.setup {
			defaults = {
				mappings = {
					i = { ["<c-t>"] = trouble.open_with_trouble },
					n = { ["<c-t>"] = trouble.open_with_trouble },
				},
			},
		}

		vim.keymap.set('n', '<leader>T', ':Telescope ', { desc = '[T]elescope' })
		require('which-key').add({
			{ '<leader> ', t.buffers,                   desc = 'Buffers' },
			{ '<leader>/', t.current_buffer_fuzzy_find, desc = 'Search Buffer' },
			{ '<leader>f', find_git_files_or_all,       desc = '[F]iles' },
			{ '<leader>F', t.find_files,                desc = 'All [F]iles' },
			{ '<leader>g', t.live_grep,                 desc = 'Live [G]rep' },
			{ '<leader>G', t.grep_string,               desc = '[G]rep string' },
			{ '<leader>s', t.lsp_document_symbols,      desc = 'Document [S]ymbols' },
			{ '<leader>S', t.lsp_workspace_symbols,     desc = 'Workspace [S]ymbols' },
			{ '<leader>d', t.diagnostics,               desc = '[D]iagnostics' },
			{ '<leader>H', t.help_tags,                 desc = '[H]elp tags' }
		}, { prefix = '<leader>' })
	end
}
