local u = require('capitalize_utils')
local M = {}

M.change_capitalization_base_on_lsp = function()
	local labels = u.get_cmp_labels()
	u.change_capitalization_of_word_under_cursor_from_options(labels)
end

return M
