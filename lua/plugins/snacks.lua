return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = false },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		terminal = { enabled = true },
		gitbrowse = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		{ "<leader>uh", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
		{ "<leader>us", function() Snacks.notifier.show_history() end,   desc = "Dismiss All Notifications" },
		{ "<leader>b",  function() Snacks.gitbrowse() end,               desc = "Git Browse" },
		{ "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal" },
		{ "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore" },
		{ "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",           mode = { "n", "t" } },
		{ "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",           mode = { "n", "t" } },
	}
}
