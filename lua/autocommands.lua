-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnumber = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local on_lsp_attach = function(client, bufnr)
			local opts = { buffer = bufnr }
			local w_desc = function(desc)
				return { buffer = bufnr, desc = desc }
			end
			local wd = client.config.root_dir or vim.fn.getcwd()
			vim.fn.chdir(wd)

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
			vim.keymap.set({ 'n' }, '<leader>.', vim.lsp.buf.code_action, w_desc('Code Action'))
			vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, w_desc('Rename'))

			-- Workspaces
			vim.keymap.set({ 'n' }, '<leader>wa', vim.lsp.buf.add_workspace_folder,
				{ desc = '[A]dd workspace directory' })
			vim.keymap.set({ 'n' }, '<leader>wr', vim.lsp.buf.remove_workspace_folder,
				{ desc = '[R]emove workspace directory' })
			vim.keymap.set({ 'n' }, '<leader>wl',
				function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
				{ desc = '[L]ist workspace directory' })
		end
		on_lsp_attach(client, bufnumber)
	end,
})
