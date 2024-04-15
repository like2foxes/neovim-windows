return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function()
		require('which-key').register({
			t = {
				name = '[T]rouble',
				t = { function() require('trouble').toggle() end, '[T]oggle Trouble' },
				d = { function() require('trouble').toggle('document_diagnostics') end, '[T]oggle Trouble' },
				q = { function() require('trouble').toggle('quickfix') end, '[Q]uickfix' },
				l = { function() require('trouble').toggle('loclist') end, '[L]ocal list' },
			},
		}, { prefix = '<leader>' })
	end
}
