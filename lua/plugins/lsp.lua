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
			cmd = { "/omnisharp/OmniSharp.exe" },

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

		lsp.tsserver.setup({})

		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				local w_desc = function(desc)
					return { buffer = ev.buf, desc = desc }
				end
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, w_desc('[D]eclaration'))
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, w_desc('[D]efinition'))
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, w_desc('[I]mplementation'))
				vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, w_desc('[R]eferences'))
				vim.keymap.set('n', ']d', vim.diagnostic.goto_next, w_desc('Next [D]iagnostic'))
				vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, w_desc('Previous [D]iagnostic'))

				require('which-key').register({
					l = {
						name = '[L]sp',
						a = { vim.lsp.buf.code_action, 'code [A]ction' },
						f = { function() vim.lsp.buf.format { async = true } end, '[F]ormat buffer' },
						r = { vim.lsp.buf.rename, '[R]ename' },
						t = { vim.lsp.buf.type_definition, '[T]ype definition' },
					},
					w = {
						name = '[W]orkspace',
						a = { vim.lsp.buf.add_workspace_folder, '[A]dd workspace directory' },
						r = { vim.lsp.buf.remove_workspace_folder, '[R]emove workspace directory' },
						l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, '[L]ist workspace directory' },
					}
				}, { prefix = '<leader>' })
			end,
		})
	end
}
