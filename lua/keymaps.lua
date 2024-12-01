
vim.keymap.set('n', '<Space>%', '<cmd>w<cr><cmd>source %<cr>', { desc = "Source [%]" })
-- remove highlight
vim.keymap.set('n', '<esc>', '<cmd>noh<cr>')

-- quickfix
vim.keymap.set('n', '<leader>qq', '<cmd>copen<cr>', { desc = "Open [Q]uicklist" })
vim.keymap.set({ 'n', 'v' }, ']q', '<cmd>cnext<cr>', { desc = 'Next [Q]list Item' })
vim.keymap.set({ 'n', 'v' }, '[q', '<cmd>cprevious<cr>', { desc = 'Previous [Q]list Item' })

vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

vim.keymap.set("n", "<leader>o", "o<esc>k", { desc = "Enter empty line below" })
vim.keymap.set("n", "<leader>O", "O<esc>j", { desc = "Enter empty line above" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

local t = require('telescope.builtin')
local find_git_files_or_all = function()
	local ok, _ = pcall(t.git_files)
	if not ok then
		t.find_files()
	end
end

vim.keymap.set('n', '<Leader>T', ':Telescope ', { desc = '[T]elescope' })
vim.keymap.set('n', '<Leader> ', t.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<Leader>/', t.current_buffer_fuzzy_find, { desc = 'Search Buffer' })
vim.keymap.set('n', '<Leader>f', find_git_files_or_all, { desc = '[F]iles' })
vim.keymap.set('n', '<Leader>F', t.find_files, { desc = 'All [F]iles' })
vim.keymap.set('n', '<Leader>g', t.live_grep, { desc = 'Live [G]rep' })
vim.keymap.set('n', '<Leader>G', t.grep_string, { desc = '[G]rep string' })
vim.keymap.set('n', '<Leader>S', t.lsp_document_symbols, { desc = 'Document [S]ymbols' })
vim.keymap.set('n', '<Leader>D', t.diagnostics, { desc = '[D]iagnostics' })
vim.keymap.set('n', '<Leader>h', t.help_tags, { desc = '[H]elp tags' })
vim.keymap.set('n', '<Leader>R', t.lsp_references, { desc = '[R]eferences' })

local o = require('oil')
vim.keymap.set('n', '<Leader>e', o.toggle_float, { desc = 'Toggle Oil' })
vim.keymap.set('n', '<Leader>E', function() o.toggle_float(vim.cmd.pwd()) end, { desc = 'Toggle Oil in pwd' })

vim.keymap.set('i', '<C-L>', 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false
})

vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<C-S>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-Z>', '<Plug>(copilot-accept-line)')
vim.keymap.set('i', '<C-]>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-D>', '<Plug>(copilot-dismiss)')

vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = 'kanagawa',
	-- group = ...,
	callback = function()
		vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
			fg = '#555555',
			ctermfg = 8,
			force = true
		})
	end
})
