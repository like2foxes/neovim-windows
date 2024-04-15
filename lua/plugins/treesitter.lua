return {
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require 'nvim-treesitter.configs'.setup({
				ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
				build = ':TSUpdate',
				sync_install = false,
				auto_install = true,
				ignore_install = {},
				modules = {},
				highlight = {
					enable = true,
					disable = {},
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
				},
				indent = {
					enable = true
				}
			})
			local selection = require('nvim-treesitter.incremental_selection')
			local to = require('nvim-treesitter.textobjects.move')

			vim.keymap.set({ 'n', 'v' }, ']q', '<cmd>cnext<cr>', { desc = 'Next [Q]list Item' })
			vim.keymap.set({ 'n', 'v' }, '[q', '<cmd>cprevious<cr>', { desc = 'Previous [Q]list Item' })

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

			require('which-key').register({
				s = { selection.init_selection, 'Init [S]election' },
				S = { selection.scope_incremental, '[S]cope selection' },
				c = { function() require('treesitter-context').go_to_context(vim.v.count1) end, 'Go to [C]ontext' },
			}, { prefix = '<leader>' })

			require('which-key').register({
				s = { selection.node_incremental, 'Increment [S]election' },
				d = { selection.node_decremental, '[D]ecrement [S]election' },
				[' '] = { selection.scope_incremental, 'Scope Selection' },

			}, { prefix = '<leader>', mode = 'v' })
		end
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		dependencies = {
			'nvim-treesitter/nvim-treesitter'
		}
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = {
			'nvim-treesitter/nvim-treesitter'
		},
	},
}
