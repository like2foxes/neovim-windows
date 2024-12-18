return {
	'neovim/nvim-lspconfig',
	event = { "BufReadPre", "BufNewFile", "BufReadPost" },
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
	config = function(_, opts)
		local lsp = require('lspconfig')
		lsp.lua_ls.setup({
			single_file_support = true,
			on_init = function(client)
				local path = client.workspace_folders[1].name
				if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
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
			--cmd = { 'pwsh', '-NoLogo', '-NoProfile', '-Command', "C:/tools/PowerShellEditorServices/PowerShellEditorServices/Start-EditorServices.ps1" },
			bundle_path = "C:/tools/PowerShellEditorServices/PowerShellEditorServices",
			single_file_support = true,
		})

		lsp.pyright.setup({})
		lsp.clangd.setup({})

		lsp.ts_ls.setup({})

		lsp.jsonls.setup({})

		lsp.gopls.setup({})

		lsp.fsautocomplete.setup({})

		lsp.html.setup({})

		lsp.cssls.setup({})
		lsp.intelephense.setup {}
		if vim.fn.hostname() == "DT-DOTNET-10" then
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			for _, server in pairs(lsp) do
				server.capabilities = capabilities
			end
		end
	end
}
