return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		cond = not vim.g.vscode,
		priority = 1000,
		config = function()
			local colors = require("rose-pine.palette")
			local config = require("rose-pine.config").options

			require("rose-pine").setup({
				-- variant = "moon",
				dark_variant = "moon",
				disable_background = true,
				groups = {
					git_text = "gold",
				},
				highlight_groups = {
					LineNr = { fg = "highlight_high" },
					AbsLineNr = { fg = "highlight_med" },
					CursorLineNr = { fg = "iris", bg = "highlight_low" },
					CursorLineSign = { fg = "text", bg = "highlight_low" },
					IblIndent = { fg = "highlight_low", bold = false },
					IblScope = { fg = "highlight_high" },
					Folded = { fg = "highlight_high" },
					Visual = { bg = "pine", blend = 50 },
					WinSeparator = { fg = "nc", bold = true },
					Keyword = { fg = "iris" },
					["@function.call"] = { fg = "foam", italic = true },
					["@type.qualifier"] = { fg = "pine" },
					SpellBad = { fg = colors.love, italic = true, undercurl = true },
					SpellCap = { fg = colors.love, italic = true, undercurl = true },
					SpellLocal = { fg = colors.pine, italic = true, undercurl = true },
					SpellRare = { fg = colors.gold, italic = true, undercurl = true },
					Hlargs = { link = "@parameter", bold = true },
					HlargsNamedParams = { link = "@parameter", bold = true },
					-- Quick fix
					qfSeparator = { fg = colors.subtle },
					qfLineNr = { fg = colors.love },
					qfFileName = { fg = colors.subtle, italic = true, bold = false },
					qfError = { fg = colors.love, bold = true, italic = true },
					QuickFixLine = { bg = "pine", blend = 15 },
					-- Diff
					DiffViewDiffDelete = { fg = "highlight_med" },
					["@text.diff.delete"] = { fg = "text", bg = config.groups.git_delete, blend = 20 },
					["@text.diff.add"] = { fg = "text", bg = config.groups.git_add, blend = 20 },
					["@attribute.diff"] = { fg = "iris" },
					["@text.title.gitcommit"] = { fg = "foam", bold = true },
					GitSignsAdd = { fg = "pine", bg = "none" },

					GitSignsChange = { fg = colors.git_change, bg= "none" },
					GitSignsDelete = { fg = colors.git_delete, bg= "none" },
					SagaNormal = { bg = "surface" },
					-- Tree
					NeoTreeGitUntracked = { fg = "pine" },
					NeoTreeGitUnstaged = { fg = "iris" },
					NeoTreeGitConflict = { fg = "love" },
					NeoTreeGitModified = { fg = "gold" },
					NeoTreeGitAdded = { fg = config.groups.git_add },
					NeoTreeGitDeleted = { fg = config.groups.git_delete },
					NeoTreeGitIgnored = { fg = config.groups.git_ignore },
					NeoTreeGitStaged = { fg = config.groups.git_stage },
					-- NeoTreeNormal = { bg = "surface" },
					-- NeoTreeNormalNC = { bg = "surface" },
					NeoTreeMessage = { fg = "muted" },
					NeoTreeDotfile = { fg = "muted" },
					NeoTreeCursorLine = { bg = "pine", blend = 20 },
					--

					TroubleNormal = { bg = "surface" },
					NormalOverlay = { bg = "surface" },
					-- Treesitter context
					TreesitterContext = { bg = "iris", blend = 5 },
					TreesitterContextBottom = { underline = true, fg = "highlight_med" },
					-- Matchparen
					MatchParen = { fg = "gold", bg = "pine", blend = 50 },
					-- BQF
					BqfPreviewFloat = { fg = "muted", bg = "#00000000", blend = 15 },
					BqfPreviewBorder = { link = "BqfPreviewFloat" },
					-- Cmd
					CmdOverlay = { bg = "#000000", blend = 10 },
					-- help slow-fast-terminal
					NonText = { fg = "none" },
				},
			})

			vim.cmd.colorscheme("rose-pine")
		end,
	},
}
