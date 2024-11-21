vim.bo.expandtab = true

local proj_dir = vim.fs.root(0, function(name, _)
	return name:match('%.csproj$') ~= nil
end)

local proj_name
local proj
if proj_dir then
	for entry in vim.fs.dir(proj_dir) do
		if entry:match('%.csproj') then
			proj_name = entry
		end
	end
	if proj_dir and proj then
		proj = proj_dir .. "/" .. proj_name
	end
end


vim.bo.makeprg = "dotnet run " .. (proj or "")

local compose_command = function(watched)
	local enter_code = vim.api.nvim_replace_termcodes("<CR>", false, false, true)
	if watched == nil or watched == "" then
		return enter_code
	end
	return " --project " .. watched .. enter_code
end

local u = require("terminal_utils")
vim.api.nvim_create_user_command("Watch",
	function(args)
		local watched = proj
		if args ~= nil and args['args'] and string.len(args['args']) > 0 then
			watched = args['args']
		end
		local win = vim.api.nvim_get_current_win()
		u.terminal_send_cmd("dotnet watch run" .. compose_command(watched))
		vim.api.nvim_set_current_win(win)
	end, { bang = true, nargs = "?" })

vim.api.nvim_create_user_command("Test",
	function(args)
		local watched = proj
		if args ~= nil and args['args'] and string.len(args['args']) > 0 then
			watched = args['args']
		end
		local win = vim.api.nvim_get_current_win()
		u.terminal_send_cmd("dotnet watch test" .. compose_command(watched))
		vim.api.nvim_set_current_win(win)
	end, { bang = true, nargs = "?" })
