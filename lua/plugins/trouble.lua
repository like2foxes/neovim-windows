return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function()
		require('which-key').add({
			group = '[T]rouble',
			{ '<leader>tt', function() require('trouble').toggle() end,                       desc = '[T]oggle Trouble' },
			{ '<leader>td', function() require('trouble').toggle('document_diagnostics') end, desc = '[T]oggle Trouble' },
			{ '<leader>tq', function() require('trouble').toggle('quickfix') end,             desc = '[Q]uickfix' },
			{ '<leader>tl', function() require('trouble').toggle('loclist') end,              desc = '[L]ocal list' },
		})
	end
}
