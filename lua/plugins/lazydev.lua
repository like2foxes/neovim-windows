return {
	{ "justinsgithub/wezterm-types", lazy = true },
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		library = {
			opts = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library",  words = { "vim%.uv" } },
				{ path = "wezterm-types",       mods = { "wezterm" } },
				{ path = "${3rd}/love2d/library", words = { "love" } },
			},
		},
	}
}
