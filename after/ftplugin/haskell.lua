vim.bo.expandtab = true
local ht = require('haskell-tools')
local bufnr = vim.api.nvim_get_current_buf()
local w_desc = function(desc)
	return { noremap = true, buffer = bufnr, desc = desc }
end
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set('n', '<leader>tl', vim.lsp.codelens.run, w_desc("CodeLens"))
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set('n', '<leader>ts', ht.hoogle.hoogle_signature, w_desc("Hoogle"))
-- Evaluate all code snippets
vim.keymap.set('n', '<leader>ta', ht.lsp.buf_eval_all, w_desc("Eval all"))
-- Toggle a GHCi repl for the current package
vim.keymap.set('n', '<leader>tp', ht.repl.toggle, w_desc("Repl toggle"))
-- Toggle a GHCi repl for the current buffer
vim.keymap.set('n', '<leader>tb', function()
	ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, w_desc("Repl toggle for buffer"))
vim.keymap.set('n', '<leader>rq', ht.repl.quit, w_desc("Repl quit"))
