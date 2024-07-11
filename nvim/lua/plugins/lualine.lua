if vim.g.vscode then
	return {}
end
local icons = require("user.icons")

return {
	-- Set lualine as statusline
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	-- See `:help lualine.txt`
	priority = 1010,
	config = function()
		-- local theme = require("lualine.themes.rose-pine")
		-- local p = require("rose-pine.palette")

		-- Make the line transparent
		-- theme.normal.c.bg = "none"
		-- theme.normal.c.fg = p.muted
		-- theme.normal.b.bg = p.overlay
		-- theme.normal.y = { fg = p.subtle, bg = p.overlay }
		-- theme.normal.x = { fg = p.rose, bg = "none" }
		--
		-- theme.insert.c.bg = "none"
		-- theme.insert.c.fg = p.muted
		-- theme.insert.b.bg = p.overlay
		-- theme.insert.y = { fg = p.subtle, bg = p.overlay }
		-- theme.insert.x = { fg = p.rose, bg = "none" }
		--
		-- theme.visual.c.bg = "none"
		-- theme.visual.c.fg = p.muted
		-- theme.visual.b.bg = p.overlay
		-- theme.visual.y = { fg = p.subtle, bg = p.overlay }
		-- theme.visual.x = { fg = p.rose, bg = "none" }
		--
		-- theme.command.c.bg = "none"
		-- theme.command.c.fg = p.muted
		-- theme.command.b.bg = p.overlay
		-- theme.command.y = { fg = p.subtle, bg = p.overlay }
		-- theme.command.x = { fg = p.rose, bg = "none" }

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "  ", right = "" },
				section_separators = { right = " ", left = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { { "%{ ' ' } ", draw_empty = true, padding = 0 } },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = {
					{ "branch", icon = icons.git.Branch },
				},
				lualine_y = { { "filetype", padding = 2 }, { "location", padding = { right = 1 } } },
				lualine_z = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						colored = false,
					},
					{
						"reg_recording",
					},
					{
						function()
							local ok, pomo = pcall(require, "pomo")
							if not ok then
								return ""
							end

							local timer = pomo.get_first_to_finish()
							if timer == nil then
								return ""
							end

							return " " .. tostring(timer)
						end,
					},
				},
			},
			inactive_sections = {
				lualine_a = { "" },
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
