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

		local trouble = require("trouble.providers.telescope")
		local telescope = require("telescope")

		telescope.setup {
			defaults = {
				mappings = {
					i = { ["<c-t>"] = trouble.open_with_trouble },
					n = { ["<c-t>"] = trouble.open_with_trouble },
				},
			},
		}

		vim.keymap.set('n', '<leader>T', ':Telescope ', {desc = '[T]elescope'})
		require('which-key').register({
			[' '] = { t.buffers, 'Buffers' },
			['/'] = { t.current_buffer_fuzzy_find, 'Search Buffer' },
			f = { find_git_files_or_all, '[F]iles' },
			F = { t.find_files, 'All [F]iles' },
			g = { t.live_grep, 'Live [G]rep' },
			G = { t.grep_string, '[G]rep string' },
			s = { t.lsp_document_symbols, 'Document [S]ymbols' },
			S = { t.lsp_workspace_symbols, 'Workspace [S]ymbols' },
			d = { t.diagnostics, '[D]iagnostics' },
		}, { prefix = '<leader>' })
	end
}
