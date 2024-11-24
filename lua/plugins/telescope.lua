return {
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local function find_command()
			if 1 == vim.fn.executable("rg") then
				return { "rg", "--files", "--color", "never", "-g", "!.git" }
			elseif 1 == vim.fn.executable("fd") then
				return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
			elseif 1 == vim.fn.executable("fdfind") then
				return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
			elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
				return { "find", ".", "-type", "f" }
			elseif 1 == vim.fn.executable("where") then
				return { "where", "/r", ".", "*" }
			end
		end
		require('telescope').setup({
			pickers = {
				find_files = {
					find_command = find_command
				},
				git_files = {
					show_untracked = true
				}
			}
		})
		local t = require('telescope.builtin')
		local find_git_files_or_all = function()
			local ok, _ = pcall(t.git_files)
			if not ok then
				t.find_files()
			end
		end

		vim.keymap.set('n', '<Leader>T', ':Telescope ', { desc = '[T]elescope' })
		vim.keymap.set('n', '<Leader> ', t.buffers, { desc = 'Buffers' })
		vim.keymap.set('n', '<Leader>/', t.current_buffer_fuzzy_find, { desc = 'Search Buffer' })
		vim.keymap.set('n', '<Leader>f', find_git_files_or_all, { desc = '[F]iles' })
		vim.keymap.set('n', '<Leader>F', t.find_files, { desc = 'All [F]iles' })
		vim.keymap.set('n', '<Leader>g', t.live_grep, { desc = 'Live [G]rep' })
		vim.keymap.set('n', '<Leader>G', t.grep_string, { desc = '[G]rep string' })
		vim.keymap.set('n', '<Leader>s', t.lsp_document_symbols, { desc = 'Document [S]ymbols' })
		vim.keymap.set('n', '<Leader>S', t.lsp_workspace_symbols, { desc = 'Workspace [S]ymbols' })
		vim.keymap.set('n', '<Leader>D', t.diagnostics, { desc = '[D]iagnostics' })
		vim.keymap.set('n', '<Leader>H', t.help_tags, { desc = '[H]elp tags' })
		vim.keymap.set('n', '<Leader>R', t.lsp_references, { desc = '[R]eferences' })
	end
}
