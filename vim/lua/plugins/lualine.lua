if vim.g.vscode then
	return {}
end

return {
	-- Set lualine as statusline
	"nvim-lualine/lualine.nvim",
	-- See `:help lualine.txt`
	config = function()
		local theme = require("lualine.themes.rose-pine")
		local p = require('rose-pine.palette')

		-- Make the line transparent
		theme.normal.c.bg = "none"
		theme.normal.c.fg = p.muted

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = theme,
				component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
				section_separators = { right = "", left = " " },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "branch", "filetype" },
				lualine_y = { "location" },
				lualine_z = {
					{
						"diagnostics",
						sources = { "ale", "nvim_diagnostic" },
						colored = false,
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
