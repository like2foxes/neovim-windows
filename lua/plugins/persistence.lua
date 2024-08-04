return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	opts = {},
	init = function()
		require('which-key').add({
				group = 'Session',
				{ '<leader>qs', '<cmd>lua require("persistence").load()<cr>', desc = 'Load [S]ession' },
				{ '<leader>ql', '<cmd>lua require("persistence").load()<cr>', desc = 'Load [L]ast Session' },
				{ '<leader>qd', '<cmd>lua require("persistence").stop()<cr>', desc = '[D]on\'t Save on Exit' },
		})
	end
}
