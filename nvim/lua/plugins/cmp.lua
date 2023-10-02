return {
	-- {
	-- 	"tzachar/cmp-fuzzy-buffer",
	-- 	dependencies = {
	-- 		"romgrk/fzy-lua-native",
	-- 		"tzachar/fuzzy.nvim",
	-- 	}
	-- },
	{
		"hrsh7th/nvim-cmp",
		cond = not vim.g.vscode,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			-- "tzachar/cmp-fuzzy-buffer",
			"hrsh7th/cmp-path",
			"petertriho/cmp-git",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local compare = require("cmp.config.compare")

			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup({
				experimental = {
					ghost_text = true
				},

				window = {
					documentation = cmp.config.window.bordered(),
					-- completion = cmp.config.window.bordered(),
				},

				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
							-- elseif luasnip.expand_or_jumpable() then
							-- 	luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
							-- elseif luasnip.jumpable(-1) then
							-- 	luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = -1 },
					{
						name = "buffer",
						option = {
							get_bufnrs = function()
								local bufs = {}
								for _, buf in ipairs(vim.api.nvim_list_bufs()) do
									local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
									if buftype ~= 'nofile' and buftype ~= 'prompt' then
										bufs[#bufs + 1] = buf
									end
								end
								return bufs
							end
						}
					},
					{ name = "path" },
					{ name = "git" },
				}),
				-- sorting = {
				-- 	priority_weight = 20,
				-- 	-- comparators = {
				-- 	-- 	compare.kind,
				-- 	-- 	compare.offset,
				-- 	-- 	compare.recently_used,
				-- 	-- 	compare.exact,
				-- 	-- 	compare.score,
				-- 	-- 	compare.sort_text,
				-- 	-- 	compare.length,
				-- 	-- 	compare.order,
				-- 	-- },
				-- },
				formatting = {
					format = lspkind.cmp_format({
						-- mode = "symbol_text", -- show only symbol annotations
						-- maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- ellipsis_char = "…", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						menu = {
							fuzzy_buffer = "[Fuzzy Buffer]",
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							nvim_lua = "[Lua]",
							git = "[Git]",
							path = "[Path]",
						},
					}),
				},
			})
		end
	},
}
