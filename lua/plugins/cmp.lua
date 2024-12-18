if vim.fn.hostname() == "DT-DOTNET-10" then
	return {
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},

		config = function()
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			-- Customization for Pmenu
			vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
			vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

			vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
			vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

			vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
			vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
			vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

			vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
			vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
			vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

			vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
			vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
			vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

			vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
			vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
			vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
			vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
			vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

			vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
			vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

			vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
			vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
			vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

			vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
			vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
			vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

			vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
			vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
			vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })

			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			local auto_select = false
			cmp.setup({
				auto_brackets = {}, -- configure any filetype to auto add brackets
				completion = {
					completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
				},
				preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
				mapping = {
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = false }),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-y>"] = cmp.mapping(
						cmp.mapping.confirm {
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						},
						{ "i", "c" }
					),
					["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				},

				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = 'nvim_lsp_signature_help' }
				}, {
					{
						name = "lazydev",
						group_index = 0
					}
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry,
							vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						return kind
					end,
				},
				window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
					},
				},
				experimental = {
					-- only show ghost text when we show ai completions
					ghost_text = vim.g.ai_cmp and {
						hl_group = "CmpGhostText",
					} or false,
				},
				sorting = defaults.sorting,
			})
			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				}),
				matching = { disallow_symbol_nonprefix_matching = false }
			})
		end
	}
else
	return {}
end
