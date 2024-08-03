return {
    "TheLeoP/powershell.nvim",
    opts = {
      bundle_path = 'path/to/your/bundle_path/'
    },
	config = function()
		require('powershell').setup({})
	end
}
