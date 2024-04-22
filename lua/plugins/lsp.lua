return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'Hoffs/omnisharp-extended-lsp.nvim',
	},
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
			settings = {
				FormattingOptions = {
					EnableEditorConfigSupport = true,
					OrganizeImports = nil,
				},
				MsBuild = {
					LoadProjectsOnDemand = false,
				},
				RoslynExtensionsOptions = {
					EnableDecompilationSupport = true,
					EnableAnalyzersSupport = true,
					EnableImportCompletion = true,
					AnalyzeOpenDocumentsOnly = false,
				},
				Sdk = {
					IncludePrereleases = true,
				},
			},
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

				local is_omni = function()
					for _, value in pairs(vim.lsp.get_active_clients()) do
						if value.name == 'omnisharp' then
							return true
						end
					end
					return false
				end

				if is_omni() then
					local oe = require('omnisharp_extended')
					vim.keymap.set('n', 'gd', oe.lsp_definition, w_desc('[D]efinition'))
					vim.keymap.set('n', 'gi', oe.lsp_implementation, w_desc('[I]mplementation'))
					vim.keymap.set('n', 'gr', oe.lsp_references, w_desc('[R]eferences'))
				else
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, w_desc('[D]efinition'))
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, w_desc('[I]mplementation'))
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, w_desc('[R]eferences'))
				end
				--vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, w_desc('[D]eclaration'))
				vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', ']d', vim.diagnostic.goto_next, w_desc('Next [D]iagnostic'))
				vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, w_desc('Previous [D]iagnostic'))
				vim.keymap.set('n', '<leader>\'', function() vim.lsp.buf.format { async = true } end,
					w_desc('Format buffer'))
				vim.keymap.set(
					'v', '<leader>\'',
					function()
						vim.lsp.buf.format {
							async = true,
							range = {
								['start'] = vim.api.nvim_buf_get_mark(0, '<'),
								['end'] = vim.api.nvim_buf_get_mark(0, '>')
							}
						}
					end,
					w_desc('Format buffer')
				)
				vim.keymap.set({ 'n' }, '<leader>.', '<cmd>Lspsaga code_action<cr>', w_desc('Code Action'))
				vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, w_desc('Rename'))

				require('which-key').register({
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
