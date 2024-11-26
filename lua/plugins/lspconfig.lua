return {
	'neovim/nvim-lspconfig',
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	opts = {
		diagnostics = {
			underline = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
				-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
				-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
				-- prefix = "icons",
			},
			severity_sort = true,
		},
		inlay_hints = {
			enabled = true
		},
	},
	config = function()
		local lsp = require('lspconfig')
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		lsp.lua_ls.setup({
			capabilities = capabilities,
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
						library = vim.api.nvim_get_runtime_file("", true),
					}
				})
			end,
			settings = {
				Lua = {}
			}
		})

		lsp.powershell_es.setup({
			capabilities = capabilities,
			cmd = { 'pwsh', '-NoLogo', '-NoProfile', '-Command', "C:/tools/PowerShellEditorServices/PowerShellEditorServices/Start-EditorServices.ps1" },
			single_file_support = true,
		})

		lsp.pyright.setup({ capabilities = capabilities })
		lsp.clangd.setup({ capabilities = capabilities })

		lsp.ts_ls.setup({ capabilities = capabilities })

		lsp.jsonls.setup({ capabilities = capabilities })

		lsp.gopls.setup({ capabilities = capabilities })

		lsp.fsautocomplete.setup({ capabilities = capabilities })

		lsp.html.setup({ capabilities = capabilities })

		lsp.cssls.setup({ capabilities = capabilities })
		lsp.intelephense.setup {}
	end
}
