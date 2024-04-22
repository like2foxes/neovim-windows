local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local actions = require 'telescope.actions'
local previewers = require 'telescope.previewers'
local action_state = require 'telescope.actions.state'

local conf = require('telescope.config').values

local get_projects = function()
	local root = vim.lsp.buf.list_workspace_folders()[1] or vim.loop.cwd()
	local projects = vim.fs.find(function(name, path)
		return name:match('.*%.csproj$')
	end, { path = root, limit = 100, type = 'file' })
	return projects
end

local dotnet_project_picker = function(opts)
	opts = opts or require('telescope.config')
	local projects = get_projects()
	if #projects == 0 then
		print('no dotnet projects')
		return
	end
	pickers.new(opts, {
		prompt_title = 'dotnet projects',
		finder = finders.new_table {
			results = get_projects(),
			entry_maker = function(entry)
				return {
					path = entry,
					value = entry,
					display = vim.fs.basename(entry):gsub("%.csproj", ""),
					ordinal = entry,
				}
			end,
		},
		sorter = conf.generic_sorter(opts),
		previewer = conf.file_previewer(opts),
	}):find()
end

return { Dotnet_picker = dotnet_project_picker }
