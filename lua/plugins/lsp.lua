return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v3.x',
	dependencies = {
		{ 'neovim/nvim-lspconfig' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/nvim-cmp' },
		{ 'L3MON4D3/LuaSnip' },
		{ 'Hoffs/omnisharp-extended-lsp.nvim' }
	},

	config = function()
		local lsp_zero = require('lsp-zero')
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
			cmd = { "OmniSharp.exe" },
			handlers = {
				["textDocument/definition"] = require('omnisharp_extended').definition_handler,
				["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
				["textDocument/references"] = require('omnisharp_extended').references_handler,
				["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
			},
		}

		lsp.clangd.setup({

		})

		lsp.tsserver.setup({})

		lsp.jsonls.setup({})

		lsp_zero.on_attach(function(client, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			lsp_zero.default_keymaps({ buffer = bufnr })
			local opts = { buffer = bufnr }
			local w_desc = function(desc)
				return { buffer = bufnr, desc = desc }
			end

			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, w_desc('[D]efinition'))
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, w_desc('[I]mplementation'))
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, w_desc('[R]eferences'))
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
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

			vim.keymap.set({ 'n' }, '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = '[A]dd workspace directory' })
			vim.keymap.set({ 'n' }, '<leader>wr', vim.lsp.buf.remove_workspace_folder,
				{ desc = '[R]emove workspace directory' })
			vim.keymap.set({ 'n' }, '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
				{ desc = '[L]ist workspace directory' })
		end)
	end
}
