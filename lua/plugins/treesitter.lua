return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = true,
		config = function()
			vim.filetype.add({
				pattern = { [".*%.blade%.php"] = "blade" }
			})
			require 'nvim-treesitter.configs'.setup({
				ensure_installed = { "blade", "php_only" },
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
				},
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							["af"] = { query = "@function.outer", desc = 'Outer function' },
							["if"] = { query = "@function.inner", desc = 'Inner function' },
							["ac"] = { query = "@class.outer", desc = 'Outer class' },
							["ic"] = { query = "@class.inner", desc = 'Inner class' },
						},
					}
				}
			})

			--@class
			local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
			parser_config.blade = {
				install_info = {
					url = "https://github.com/EmranMR/tree-sitter-blade",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetype = "blade",
			}
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

			-- go to context
			vim.keymap.set({ 'v', 'c' }, 'gc', function() require('treesitter-context').go_to_context(vim.v.count1) end,
				{ desc = 'Go to Context' })

			-- selection
			vim.keymap.set('n', '<leader>i', selection.init_selection, { desc = '[I]nit Selection' })
			vim.keymap.set('n', '<leader>I', selection.scope_incremental, { desc = '[I]n Scope selection' })
			vim.keymap.set('v', '<leader>s', selection.node_incremental, { desc = 'Increment [S]election' })
			vim.keymap.set('v', '<leader>d', selection.node_decremental, { desc = '[D]ecrement [S]election' })
			vim.keymap.set('v', '<leader> ', selection.scope_incremental, { desc = 'Scope Selection' })
		end
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		lazy = true,
		dependencies = {
			'nvim-treesitter/nvim-treesitter'
		}
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		lazy = true,
		dependencies = {
			'nvim-treesitter/nvim-treesitter'
		},
	},
}
