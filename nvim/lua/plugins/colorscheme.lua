return {
	{
		"rose-pine/neovim",
		name = "rose-pine-neovim",
		cond = not vim.g.vscode,
		priority = 10000,
		config = function()
			local colors = require("rose-pine.palette")
			local variant = "moon"

			require("rose-pine").setup({
				variant = variant,
				groups = {
					git_text = "gold",
				},
			})

			local config = require("rose-pine.config").options

			require("rose-pine").colorscheme({
				disable_background = variant == "moon",
				highlight_groups = {
					LineNr = { fg = "highlight_high" },
					AbsLineNr = { fg = "highlight_med" },
					CursorLineNr = { fg = "iris", bg = "highlight_low" },
					CursorLineSign = { fg = "text", bg = "highlight_low" },
					IndentBlanklineChar = { fg = "highlight_low" },
					IndentBlanklineContextChar = { fg = "highlight_med" },
					Type = { fg = "text" },
					Keyword = { fg = "iris" },
					Folded = { fg = "highlight_high" },
					Visual = { bg = "pine", blend = 20 },
					["@function.call"] = { fg = "foam", italic = true },
					["@lsp.type.property.lua"] = { fg = "text" },
					["@text.title.gitcommit"] = { fg = "foam", bold = true },
					["@text.diff.delete"] = { fg = "text", bg = config.groups.git_delete, blend = 20 },
					["@text.diff.add"] = { fg = "text", bg = config.groups.git_add, blend = 20 },
					["@attribute.diff"] = { fg = "iris" },
					["@type.qualifier"] = { fg = "pine" },
					["@parameter"] = { fg = "text", italic = true },
					SpellBad = { fg = colors.love, italic = true, undercurl = true },
					SpellCap = { fg = colors.love, italic = true, undercurl = true },
					SpellLocal = { fg = colors.pine, italic = true, undercurl = true },
					SpellRare = { fg = colors.gold, italic = true, undercurl = true },
					Hlargs = { link = "@parameter", bold = true },
					HlargsNamedParams = { link = "@parameter", bold = true },
					qfSeparator = { fg = colors.subtle },
					qfLineNr = { fg = colors.pine },
					qfFileName = { fg = colors.subtle, italic = true, bold = false },
					qfError = { fg = colors.love, bold = true, italic = true },
					QuickFixLine = { bg = "pine", blend = 10 },
					DiffViewDiffDelete = { fg = "highlight_med" },
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
					NeoTreeNormal = { bg = "surface" },
					NeoTreeNormalNC = { bg = "surface" },
					NeoTreeMessage = { fg = "muted" },
					NeoTreeDotfile = { fg = "muted" },
					NeoTreeCursorLine = { bg = "pine", blend = 20 },

					--

					TroubleNormal = { bg = "surface" },
					NormalOverlay = { bg = "surface" },
					-- Treesitter context
					TreesitterContext = { bg = "iris", blend = 5 },
					TreesitterContextBottom = { underline = true, sp = "highlight_med" },
					-- Matchparen
					MatchParen = { fg = "gold", bg = "pine", blend = 50 },
				},
			})

			vim.cmd.colorscheme("rose-pine")
		end,
	}
}
