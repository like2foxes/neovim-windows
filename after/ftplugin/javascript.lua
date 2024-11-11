local function make()
	return "node %"
end

vim.bo.makeprg = make()
-- tab size
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true

