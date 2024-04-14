return {
	'folke/which-key.nvim',
	config = function()
		local wk = require('which-key')

		local t = require('telescope.builtin');
		local find_git_files_or_all = function()
			local ok, _ = pcall(t.git_files)
			if not ok then
				t.find_files()
			end
		end

		local selection = require('nvim-treesitter.incremental_selection')
		local to = require('nvim-treesitter.textobjects.move')

		vim.keymap.set({ 'n', 'v' }, ']f', function() to.goto_next('@function.outer') end,
			{ desc = 'Next function outer' })
		vim.keymap.set({ 'n', 'v' }, ']F', function() to.goto_next('@function.inner') end,
			{ desc = 'Next function inner' })
		vim.keymap.set({ 'n', 'v' }, '[f', function() to.goto_previous('@function.outer') end,
			{ desc = 'Previous function outer' })
		vim.keymap.set({ 'n', 'v' }, '[F', function() to.goto_previous('@function.inner') end,
			{ desc = 'Previous function inner' })

		vim.keymap.set({ 'n', 'v' }, ']b', function() to.goto_next_start('@block.outer') end,
			{ desc = 'Next block outer' })
		vim.keymap.set({ 'n', 'v' }, ']B', function() to.goto_next_end('@block.inner') end,
			{ desc = 'Next block inner' })
		vim.keymap.set({ 'n', 'v' }, '[b', function() to.goto_previous_start('@block.outer') end,
			{ desc = 'Previous block outer' })
		vim.keymap.set({ 'n', 'v' }, '[B', function() to.goto_previous_end('@block.inner') end,
			{ desc = 'Previous block inner' })

		vim.keymap.set({ 'n', 'v' }, ']c', function() to.goto_next_start('@call.outer') end,
			{ desc = 'Next call outer' })
		vim.keymap.set({ 'n', 'v' }, ']C', function() to.goto_next_start('@call.inner') end,
			{ desc = 'Next call inner' })
		vim.keymap.set({ 'n', 'v' }, '[c', function() to.goto_previous_start('@call.outer') end,
			{ desc = 'Previous call outer' })
		vim.keymap.set({ 'n', 'v' }, '[C', function() to.goto_previous_start('@call.inner') end,
			{ desc = 'Previous call inner' })

		vim.keymap.set({ 'n', 'v' }, ']a', function() to.goto_next_start('@assignment.outer') end,
			{ desc = 'Next assignment outer' })
		vim.keymap.set({ 'n', 'v' }, ']A', function() to.goto_next_start('@assignment.inner') end,
			{ desc = 'Next assignment inner' })
		vim.keymap.set({ 'n', 'v' }, '[a', function() to.goto_previous_start('@assignment.outer') end,
			{ desc = 'Previous assignment outer' })
		vim.keymap.set({ 'n', 'v' }, '[A', function() to.goto_previous_start('@assignment.inner') end,
			{ desc = 'Previous assignment inner' })

		local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

		-- Repeat movement with ; and ,
		-- ensure ; goes forward and , goes backward regardless of the last direction
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

		-- vim way: ; goes to the direction you were moving.
		-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

		-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

		wk.setup({})

		wk.register({
			[' '] = { '<cmd>Telescope buffers<cr>', 'Buffers' },
			f = {
				name = '[F]ind',
				f = { find_git_files_or_all, '[F]iles' },
				a = { '<cmd>Telescope find_files<cr>', '[A]ll files' },
				g = { '<cmd>Telescope grep_string<cr>', '[G]rep string' },
				l = { '<cmd>Telescope live_grep<cr>', '[L]ive grep' },
				s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document [S]ymbols' },
				S = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Workspace [S]ymbols' },
				r = { '<cmd>Telescope lsp_references<cr>', '[R]eferences' },
			},
			e = { '<cmd>Neotree toggle<cr>', 'Toggle [E]xplorer' },
			s = { selection.init_selection, 'Init [S]election' },
			S = { selection.scope_incremental, '[S]cope selection' },
			c = { function() require('treesitter-context').go_to_context(vim.v.count1) end, 'Go to [C]ontext' }
		}, { prefix = '<leader>' })

		wk.register({
			s = { selection.node_incremental, 'Increment [S]election' },
			d = { selection.node_decremental, '[D]ecrement [S]election' },
			[' '] = { selection.scope_incremental, 'Scope Selection' },

		}, { prefix = '<leader>', mode = 'v' })

		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				local w_desc = function(desc)
					return { buffer = ev.buf, desc = desc }
				end
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, w_desc('[D]eclaration'))
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, w_desc('[D]efinition'))
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, w_desc('[I]mplementation'))
				vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, w_desc('[R]eferences'))
				vim.keymap.set('n', ']d', vim.diagnostic.goto_next, w_desc('Next [D]iagnostic'))
				vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, w_desc('Previous [D]iagnostic'))
				wk.register({
					l = {
						name = '[L]sp',
						a = { vim.lsp.buf.code_action, 'code [A]ction' },
						f = { function() vim.lsp.buf.format { async = true } end, '[F]ormat buffer' },
						r = { vim.lsp.buf.rename, '[R]ename' },
						t = { vim.lsp.buf.type_definition, '[T]ype definition' },
					},
					w = {
						name = '[W]orkspace',
						a = { vim.lsp.buf.add_workspace_folder, '[A]dd workspace directory' },
						r = { vim.lsp.buf.remove_workspace_folder, '[R]emove workspace directory' },
						l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, '[L]ist workspace directory' },
					}
				}, { prefix = '<leader>' })
			end,
		})
	end
}
