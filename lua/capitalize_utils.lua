local M = {}

--- Request completion suggestions from lsp
--- @return string[] List of lsp completion suggestions labels
M.get_cmp_labels = function()
	local params = vim.lsp.util.make_position_params()
	local result = vim.lsp.buf_request_sync(0, 'textDocument/completion', params, 200)
	local labels = {}
	if result then
		for _, res in pairs(result) do
			if res and res.result then
				if res.result.items then
					local items = res.result.items
					for _, item in pairs(items) do
						if item.label then
							table.insert(labels, item.label)
						end
					end
				else
					for _, item in pairs(res.result) do
						if item.label then
							table.insert(labels, item.label)
						end
					end
				end
			end
		end
	end
	return labels
end

--- @param ch string
--- @return boolean
M.is_alpha_or_underscore = function(ch)
	return ch:match("%w+") ~= nil or ch == '_'
end

--- @param line string
--- @param i integer
--- @return integer, integer
--- Returns the start and end indices of the word on given i.
--- If line at index i is not a legal word character,
--- the last word before that index will be used
M.word_on_col_indices = function(line, i)
	local endi = -1
	local starti = -1
	if not M.is_alpha_or_underscore(line:sub(i, i)) then
		while not M.is_alpha_or_underscore(line:sub(i, i)) and i >= 1 do
			i = i - 1
		end
		endi = i
		while M.is_alpha_or_underscore(line:sub(i, i)) and i >= 1 do
			i = i - 1
		end
		starti = i + 1
	else
		local j = i
		while M.is_alpha_or_underscore(line:sub(i, i)) and i <= #line do
			i = i + 1
		end
		endi = i - 1
		while M.is_alpha_or_underscore(line:sub(j, j)) and i >= 1 do
			j = j - 1
		end
		starti = j + 1
	end
	return starti, endi
end

M.change_capitalization_of_word_under_cursor_from_options = function(options)
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()

	local si, ei = M.word_on_col_indices(line, col + 1)
	local word = line:sub(si, ei)
	if string.lower(word) == word then
		return
	end

	local candidate = ''
	for _, option in pairs(options) do
		if option == word then
			return
		end
		if string.lower(option) == string.lower(word) then
			candidate = option
		end
	end
	if candidate ~= '' then
		vim.api.nvim_buf_set_text(0, row - 1, si - 1, row - 1, ei, { candidate })
	end
end
return M
