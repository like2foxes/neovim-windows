return {
	"TheLeoP/powershell.nvim",
	config = function()
		require('powershell').setup({
			bundle_path = "C:/tools/PowerShellEditorServices/PowerShellEditorServices",
		})
	end,
}
