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

			require("rose-pine").setup({
				-- variant = "dawn",
				dark_variant = "moon",
				dim_inactive_windows = false,
				extend_background_behind_borders = true,
				enable = {
					migrations = true,
				},
				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},
				highlight_groups = {
					LineNr = { fg = "highlight_med" },
					AbsLineNr = { fg = "highlight_med" },
					CursorLine = { bg = "#2f2b4a" },
					CursorLineNr = { fg = "iris", bg = "highlight_low" },
					CursorLineSign = { fg = "iris", bg = "highlight_low" },
					-- Avoid underline in diffview
					-- Breaks hihlight on yank
					-- CursorLine = { ctermfg = "white" },
					MiniIndentscopeSymbol = { fg = "highlight_med" },
					Folded = { fg = "highlight_high" },
					Visual = { bg = "#f040ed", blend = 60 },
					WinSeparator = { fg = "highlight_low", bold = true },
					Comment = { fg = "muted" },

					SpellBad = { fg = colors.love, italic = true, undercurl = true },
					SpellCap = { fg = colors.love, italic = true, undercurl = true },
					SpellLocal = { fg = colors.pine, italic = true, undercurl = true },
					SpellRare = { fg = colors.gold, italic = true, undercurl = true },

					Hlargs = { link = "@parameter", bold = true },
					HlargsNamedParams = { link = "@parameter", bold = true },

					-- BQF
					BqfPreviewFloat = { fg = "highlight_low", bg = "surface" },
					BqfPreviewBorder = { link = "BqfPreviewFloat" },

					-- Quick fix
					qfSeparator = { fg = colors.subtle },
					qfLineNr = { fg = colors.love },
					qfFileName = { fg = colors.subtle, italic = true, bold = true },
					qfError = { fg = colors.love, bold = true, italic = true },
					QuickFixLine = { bg = "pine", blend = 15 },

					-- Git/Diff
					DiffvViewDim1 = { fg = "highlight_low" }, -- Makes the 'empty' slashes in diffs dim
					DiffText = { bg = config.groups.git_change, blend = 30 },
					DiffChange = { bg = config.groups.git_change, blend = 10 },
					-- DiffViewDiffDelete = { fg = "highlight_med" },
					-- DiffViewDiffAdd = { bg = config.groups.git_add, blend = 15 },
					-- ["@text.diff.delete"] = { fg = "text", bg = config.groups.git_delete, blend = 20 },
					-- ["@text.diff.add"] = { fg = "text", bg = config.groups.git_add, blend = 20 },
					-- ["@attribute.diff"] = { fg = "iris" },
					-- ["@text.title.gitcommit"] = { fg = "foam", bold = true },
					["@keyword.ruby"] = { bold = true, fg = "pine" },
					["@keyword.type.ruby"] = { bold = true, fg = "pine" },
					["@keyword.function.ruby"] = { bold = true, fg = "pine" },
					["@keyword.conditional.ruby"] = { bold = true, fg = "pine" },
					["@keyword.modifier.ruby"] = { bold = true, fg = "iris" },
					DiffviewNormal = { bg = "_nc" },
					-- DiffviewNormal = { bg = "surface" },
					DiffviewFilePanelSelected = { bg = "iris", fg = "gold", blend = 30, bold = true },

					ConflictMarkerOurs = { bg = config.groups.git_delete, blend = 10, fg = "gold" },
					ConflictMarkerTheirs = { bg = config.groups.git_add, blend = 10 },
					ConflictMarkerCommonAncestorsHunk = { bg = config.groups.git_add, blend = 20 },
					ConflictMarkerCommonAncestors = { bold = true, fg = "gold" },
					-- ConflictMarkerSeparator = { fg = "gold", bold = true },
					-- ConflictMarkerBegin = { fg = "gold", bold = true },
					-- ConflictMarkerEnd = { fg = "gold", bold = true },

					-- Matchparen
					MatchParen = { fg = "gold", bg = "pine", blend = 50 },

					-- help slow-fast-terminal
					NonText = { fg = "none" },

					-- Telescope
					TelescopeResultsComment = { fg = "muted" },
					TelescopeBorder = { fg = "highlight_high" },
					TelescopePreviewTitle = { fg = "surface", bg = "foam", bold = true },
					TelescopeResultsTitle = { fg = "surface", bg = "gold", bold = true },

					-- Noice
					NoiceCmdlinePopup = { bg = "_nc" },

					-- -- TreesiterContext
					-- TreesitterContext = { bg = "_nc", force = true },
					TreesitterContext = { bg = "surface", force = true },
					TreesitterContextBottom = { sp = "highlight_high", blend = 0, underline = true },

					-- Diagnostics
					DiagnosticVirtualTextInfo = { fg = "#2A6077", bg = "foam", blend = 5 },
					DiagnosticVirtualTextHint = { fg = "#7E6C95", bg = "iris", blend = 5 },

					DiagnosticVirtualLinesHint = { fg = "#7E6C95", bg = "iris" },
					DiagnosticVirtualLinesInfo = { fg = "#2A6077", bg = "foam" },
					DiagnosticVirtualLinesWarn = { fg = "gold", bg = "gold", blend = 30, bold = true },
					DiagnosticVirtualLinesError = { fg = "love", bg = "love", blend = 30, bold = true },

					-- Diagflow
					-- DiagnosticFloatingInfo = { fg = "#2A6077", bg = "foam", blend = 5 },
					-- DiagnosticFloatingHint = { fg = "#7E6C95", bg = "iris", blend = 5 },

					-- Dap
					DapBreakpoint = { fg = "love" },
					DapBreakpointCondition = { fg = "love" },
					DapStopped = { fg = "surface", bg = "gold" },
					DapStoppedLine = { bg = "gold", blend = 10 },
					DapUIType = { link = "Comment" },
					DapUIVariable = { link = "@lsp.type.parameter" },
					DapUIValue = { link = "Normal" },
					DapUIScope = { link = "@keyword", bold = true },
					DapUILineNumber = { link = "qfLineNr" },
					DapUIModifiedValue = { link = "@diff.minus" },
					NvimDapVirtualText = { fg = "highlight_med" },
					NvimDapVirtualTextChanged = { fg = "love" },

					-- Testing
					NeoTestDir = { bold = true, fg = "foam" },
					NeotestPassed = { fg = "#0eff7c" },
					NeotestRunning = { fg = "iris" },
					NeotestStatusFailed = { fg = "base", bg = "love" },
					NeotestStatusPassed = { fg = "base", bg = "#0eff7c" },
					NeotestStatusRunning = { fg = "base", bg = "iris" },

					-- Hop
					HopNextKey = { bg = "gold", fg = "_nc", bold = true, blend = 100 },
					HopNextKey1 = { bg = "gold", fg = "_nc", bold = true, blend = 100 },
					HopNextKey2 = { bg = "gold", fg = "_nc", bold = true, blend = 80 },

					-- Neotree
					NeoTreeNormal = { bg = "_nc" },
					NeoTreeNormalNC = { bg = "_nc" },
					-- NeoTreeNormal = { bg = "surface" },
					-- NeoTreeNormalNC = { bg = "surface" },
					--

					-- Cmp
					CmpItemKind = { fg = "pine" },
					CmpNormal = { bg = "surface" },
					-- CmpItemAbbrMatch = { fg = "iris" },
					CmpItemAbbrMatchFuzzy = { fg = "iris" },

					-- Markdown
					MarkviewHeading1 = { fg = "love", bg = "love", blend = 20 },
					MarkviewHeading2 = { fg = "gold", bg = "gold", blend = 20 },
					MarkviewHeading3 = { fg = "rose", bg = "rose", blend = 20 },
					MarkviewHeading4 = { fg = "pine", bg = "pine", blend = 20 },
					MarkviewHeading5 = { fg = "foam", bg = "foam", blend = 20 },
					MarkviewHeading6 = { fg = "iris", bg = "iris", blend = 20 },
					MarkviewCode = { bg = "highlight_low" },

					-- Copilot
					CopilotSuggestion = { fg = "iris" },
					CopilotAnnotation = { fg = "#FF00FF" },
				},
			})
		end,
	},
}
