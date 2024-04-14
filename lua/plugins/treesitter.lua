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
