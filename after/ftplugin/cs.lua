vim.bo.expandtab = true

local proj_dir = vim.fs.root(0, function(name, _)
	return name:match('%.csproj$') ~= nil
end)

local proj_name
if proj_dir then
	for entry in vim.fs.dir(proj_dir) do
		if entry:match('%.csproj') then
			proj_name = entry
		end
	end
end
local proj = proj_dir .. "/" .. proj_name

vim.bo.makeprg = "dotnet run " .. proj
print(proj)

local u = require("terminal_utils")
local enter_code = vim.api.nvim_replace_termcodes("<CR>", false, false, true)
vim.api.nvim_create_user_command("Watch",
	function(args)
		local watched = proj
		if args ~= nil and args['args'] and string.len(args['args']) > 0 then
			print('hello '..args['args'])
			watched = args['args']
		end
		local win = vim.api.nvim_get_current_win()
		u.terminal_send_cmd("dotnet watch run --project " .. watched .. enter_code)
		vim.api.nvim_set_current_win(win)
	end, { bang = true, nargs = "?" })
