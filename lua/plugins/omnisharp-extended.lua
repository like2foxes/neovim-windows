return {
	"Hoffs/omnisharp-extended-lsp.nvim",
	lazy = true,
	config = function()
		-- replaces vim.lsp.buf.definition()
		vim.keymap.set("n", "gd", "<cmd>lua require('omnisharp_extended').lsp_definition()<cr>",
			{ buffer = 0, desc = "[D]efinition" })
		-- replaces vim.lsp.buf.references()
		vim.keymap.set("n", "gr", "<cmd>lua require('omnisharp_extended').lsp_references()<cr>",
			{ buffer = 0, desc = "[R]eferences" })
		-- replaces vim.lsp.buf.implementation()
		vim.keymap.set("n", "gi", "<cmd>lua require('omnisharp_extended').lsp_implementation()<cr>",
			{ buffer = 0, desc = "[I]mplementation" })
	end
}
