return {
	'neovim/nvim-lspconfig',
	config = function()
		local lsp = require('lspconfig')

		lsp.lua_ls.setup({
			on_init = function(client)
				local path = client.workspace_folders[1].name
				if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
					return
				end

				client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = 'LuaJIT'
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = vim.api.nvim_get_runtime_file("", true)
					}
				})
			end,
			settings = {
				Lua = {}
			}
		})

		lsp.omnisharp.setup {
			cmd = { "/omnisharp/OmniSharp.exe"},

			-- Enables support for reading code style, naming convention and analyzer
			-- settings from .editorconfig.
			enable_editorconfig_support = true,

			-- If true, MSBuild project system will only load projects for files that
			-- were opened in the editor. This setting is useful for big C# codebases
			-- and allows for faster initialization of code navigation features only
			-- for projects that are relevant to code that is being edited. With this
			-- setting enabled OmniSharp may load fewer projects and may thus display
			-- incomplete reference lists for symbols.
			enable_ms_build_load_projects_on_demand = false,

			-- Enables support for roslyn analyzers, code fixes and rulesets.
			enable_roslyn_analyzers = false,

			-- Specifies whether 'using' directives should be grouped and sorted during
			-- document formatting.
			organize_imports_on_format = false,

			-- Enables support for showing unimported types and unimported extension
			-- methods in completion lists. When committed, the appropriate using
			-- directive will be added at the top of the current file. This option can
			-- have a negative impact on initial completion responsiveness,
			-- particularly for the first few completion sessions after opening a
			-- solution.
			enable_import_completion = true,

			-- Specifies whether to include preview versions of the .NET SDK when
			-- determining which version to use for project loading.
			sdk_include_prereleases = true,

			-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
			-- true
			analyze_open_documents_only = false,
		}
	end
}
