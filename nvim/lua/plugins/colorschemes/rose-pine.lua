return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		cond = not vim.g.vscode,
		priority = 1000,
		lazy = false,
		config = function()
			local colors = require("rose-pine.palette")
			local config = require("rose-pine.config").options

			-- config.groups.git_change = "iris"
			-- config.groups.git_text = "gold"
			-- config.groups.git_delete = "rose"

			require("rose-pine").setup({
				-- variant = "dawn",
				dark_variant = "moon",
				dim_inactive_windows = true,
				enable = {
					migrations = true,
				},
				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},
				groups = {
					-- git_text = "gold",
					-- git_change = "iris",
					-- git_delete = "rose",
				},
				highlight_groups = {
					LineNr = { fg = "highlight_med" },
					AbsLineNr = { fg = "highlight_med" },
					CursorLineNr = { fg = "iris", bg = "highlight_low" },
					CursorLineSign = { fg = "iris", bg = "highlight_low" },
					IblIndent = { fg = "highlight_low", bold = false },
					IblScope = { fg = "highlight_high" },
					Folded = { fg = "highlight_high" },
					Visual = { bg = "pine", blend = 50 },
					WinSeparator = { fg = "highlight_low", bold = true },
					Comment = { fg = "muted" },

					SpellBad = { fg = colors.love, italic = true, undercurl = true },
					SpellCap = { fg = colors.love, italic = true, undercurl = true },
					SpellLocal = { fg = colors.pine, italic = true, undercurl = true },
					SpellRare = { fg = colors.gold, italic = true, undercurl = true },

					-- ScrollbarThumb = { bg = "iris", blend = 50 },
					-- Keyword = { fg = "iris", bold = true },
					-- Type = { fg = "foam", bold = true },
					-- -- String = { fg = "love" },
					-- ["Identifier"] = { fg = "rose" },
					-- ["@function.call"] = { fg = "foam", italic = true },
					-- ["@type.qualifier"] = { fg = "pine" },
					-- ["@variable.member"] = { fg = "foam" },
					Hlargs = { link = "@parameter", bold = true },
					HlargsNamedParams = { link = "@parameter", bold = true },

					-- BQF
					BqfPreviewFloat = { fg = "highlight_low", bg = "#110F1A" },
					BqfPreviewBorder = { link = "BqfPreviewFloat" },

					-- Quick fix
					qfSeparator = { fg = colors.subtle },
					qfLineNr = { fg = colors.love },
					qfFileName = { fg = colors.subtle, italic = true, bold = true },
					qfError = { fg = colors.love, bold = true, italic = true },
					QuickFixLine = { bg = "pine", blend = 15 },

					-- Git/Diff
					DiffViewDiffDeleteDim = { fg = "highlight_low" }, -- Makes the 'empty' slashes in diffs dim
					-- DiffText = { bg = config.groups.git_change, blend = 30 },
					-- DiffChange = { bg = config.groups.git_change, blend = 10 },
					-- DiffViewDiffDelete = { fg = "highlight_med" },
					-- DiffViewDiffAdd = { bg = config.groups.git_add, blend = 15 },
					-- ["@text.diff.delete"] = { fg = "text", bg = config.groups.git_delete, blend = 20 },
					-- ["@text.diff.add"] = { fg = "text", bg = config.groups.git_add, blend = 20 },
					-- ["@attribute.diff"] = { fg = "iris" },
					-- ["@text.title.gitcommit"] = { fg = "foam", bold = true },
					-- GitSignsAdd = { fg = "pine", bg = "none" },
					-- GitSignsChange = { fg = colors.git_change, bg = "none" },
					-- GitSignsDelete = { fg = colors.git_delete, bg = "none" },

					-- Matchparen
					MatchParen = { fg = "gold", bg = "pine", blend = 50 },

					-- help slow-fast-terminal
					NonText = { fg = "none" },

					-- Telescope
					TelescopeResultsComment = { fg = "muted" },
					TelescopeBorder = { fg = "overlay" },
					TelescopePreviewTitle = { fg = "surface", bg = "foam", bold = true },
					TelescopeResultsTitle = { fg = "surface", bg = "gold", bold = true },

					-- -- Noice
					-- NoicePopupBorder = { fg = "overlay", bg = "surface" },
					NoiceCmdlinePopup = { bg = "#101010" },
					-- NoiceCmdlinePopupBorder = { link = "NoicePopupBorder" },
					-- NoiceCmdlinePopupBorderSearch = { link = "NoicePopupBorder" },
					-- NoiceConfirm = { fg = "text", bg = "overlay" },
					-- NoiceConfirmBorder = { fg = "surface", bg = "overlay" },

					-- -- TreesiterContext
					TreesitterContext = { bg = "_nc", force = true },
					TreesitterContextBottom = { sp = "highlight_high", blend = 0, underline = true },

					-- Diagnostics
					DiagnosticVirtualTextInfo = { fg = "#2A6077", bg = "foam", blend = 5 },
					DiagnosticVirtualTextHint = { fg = "#7E6C95", bg = "iris", blend = 5 },

					-- Dap
					DapBreakpoint = { fg = "love" },
					DapBreakpointCondition = { fg = "love" },
					DapStopped = { fg = "surface", bg = "love" },
					DapStoppedLine = { bg = "love", blend = 10 },
					-- DapUiNormal = { bg = "_nc" },
					DapUIType = { link = "Comment" },
					DapUIVariable = { link = "@lsp.type.parameter" },
					DapUIValue = { link = "Normal" },
					DapUIScope = { link = "@keyword", bold = true },
					DapUILineNumber = { link = "qfLineNr" },
					DapUIModifiedValue = { link = "@diff.minus" },
					NvimDapVirtualText = { fg = "highlight_med" },
					NvimDapVirtualTextChanged = { fg = "love" },
				},
			})
		end,
	},
}
