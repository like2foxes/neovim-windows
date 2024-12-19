return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		indent = { enabled = true },
		notifier = { enabled = true },
		statuscolumn = { enabled = true },
		scroll = { enabled = true },
		lazygit = { enabled = true },
		terminal = {
			enabled = true,
			win = {
				keys = {
					-- nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
					-- nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
					-- nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
					-- nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
				},
			},
		},
		gitbrowse = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		{ "<leader>ud", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
		{ "<leader>uh", function() Snacks.notifier.show_history() end,   desc = "Show History" },
		{ "<leader>gb", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
		{ "<c-/>",      function() Snacks.terminal.toggle() end,         desc = "Toggle Terminal",          mode = { "n", "t" } },
		{ "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore" },
		{ "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",           mode = { "n", "t" } },
		{ "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",           mode = { "n", "t" } },
		{ "<leader>gg", function() Snacks.lazygit.open() end,            desc = "Open Lazygit" },
	}
}
