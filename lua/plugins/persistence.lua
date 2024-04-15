return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	opts = {},
	config = function()
		require('which-key').register({
			q = {
				s = { '<cmd>lua require("persistence").load()<cr>', 'Load [S]ession' },
				l = { '<cmd>lua require("persistence").load()<cr>', 'Load [L]ast Session' },
				d = { '<cmd>lua require("persistence").stop()<cr>', '[D]on\'t Save on Exit' },
			},
		}, { prefix = '<leader>' })
	end
}
