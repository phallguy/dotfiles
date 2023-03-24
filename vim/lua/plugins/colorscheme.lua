return {
	{
		"rose-pine/neovim",
		name = "rose-pine-neovim",
		cond = not vim.g.vscode,
		config = function()
			local colors = require("rose-pine.palette")

			require("rose-pine").setup({
				variant = "moon",
				groups = {
					git_text = "gold",
				},
			})

			local config = require("rose-pine.config").options

			require("rose-pine").colorscheme({
				highlight_groups = {
					LineNr = { fg = "overlay" },
					CursorLineNr = { fg = "muted" },
					IndentBlanklineChar = { fg = "highlight_low" },
					IndentBlanklineContextChar = { fg = "highlight_med" },
					Type = { fg = "text" },
					Keyword = { fg = "iris" },
					Folded = { fg = "highlight_high" },
					["@function.call"] = { fg = "foam", italic = true },
					["@lsp.type.property.lua"] = { fg = "text" },
					["@text.title.gitcommit"] = { fg = "foam", bold = true },
					["@text.diff.delete"] = { fg = "text", bg = config.groups.git_delete, blend = 20 },
					["@text.diff.add"] = { fg = "text", bg = config.groups.git_add, blend = 20 },
					["@attribute.diff"] = { fg = "iris" },
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
					DiffViewDiffDelete = { fg = "highlight_med" },
					SagaNormal = { bg = "surface" },
					-- Tree
					NeoTreeGitUntracked = { fg = "gold" },
					NeoTreeGitUnstaged = { fg = "gold" },
					NeoTreeGitConflict = { fg = "love" },
					NeoTreeNormal = { bg = "surface" },
					NeoTreeNormalNC = { bg = "surface" },
					NeoTreeMessage = { fg = "muted" },
					NeoTreeDotfile = { fg = "#FFFF00" },
					NeoTreeHiddenByName = { fg = "#00FF00" },

				},
			})

			vim.cmd.colorscheme("rose-pine")
		end,
	},
	{
		-- https://github.com/marko-cerovac/material.nvim
		"marko-cerovac/material.nvim",
		cond = not vim.g.vscode,
		config = function()
			vim.g.material_style = "palenight"
			local colors = require("material.colors")

			colors.git.added = "#3e4949"
			colors.git.deleted = "#483647"
			colors.git.modified = "#2e3851"
			colors.git.untracked = "#546653"

			require("material").setup({
				contrast = {
					cursor_line = true,
					floating_windows = true,
					sidebars = true,
					non_current_windows = false,
					terminal = true,
				},
				styles = {
					functions = { bold = true },
					types = { bold = true },
					comments = { italic = true },
				},
				plugins = { -- Uncomment the plugins that you use to highlight them
					-- Available plugins:
					-- "dap",
					-- "dashboard",
					"gitsigns",
					-- "hop",
					"indent-blankline",
					"lspsaga",
					-- "mini",
					-- "neogit",
					-- "neorg",
					"nvim-cmp",
					-- "nvim-navic",
					-- "nvim-tree",
					"nvim-web-devicons",
					-- "sneak",
					"telescope",
					-- "trouble",
					"which-key",
				},
				custom_highlights = {
					IndentBlanklineChar = { fg = colors.editor.line_numbers },
					IndentBlanklineContextChar = { fg = "#63698a" },
					DiffAdd = { bg = colors.git.added },
					DiffDelete = { bg = colors.git.deleted },
					DiffChange = { bg = colors.git.modified },
					DiffviewDiffAddAsDelete = { bg = colors.git.deleted },
					DiffText = { bg = "#484443" },
					SagaNormal = { bg = colors.editor.bg_alt },
					SagaLightBulb = { fg = colors.main.yellow },
					FloatBorder = { bg = colors.editor.bg_alt, fg = colors.editor.border },
					-- SagaBorder = { bg = colors.editor.bg_alt, fg = colors.main.yellow },

					Hlargs = { fg = colors.main.darkorange },
					HlargsNamedParams = { fg = colors.main.darkorange },
					GitSignsUntracked = { fg = colors.git.untracked },
					CursorLineNr = { fg = colors.main.gray },
				},
				lualine_style = "stealth",
			})

			-- vim.cmd.colorscheme("material")
		end,
		dependencies = {
			"glepnir/lspsaga.nvim",
		},
	},
}
