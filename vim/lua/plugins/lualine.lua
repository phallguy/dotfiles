return {
	-- Set lualine as statusline
	"nvim-lualine/lualine.nvim",
	-- See `:help lualine.txt`
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {},
			lualine_c = { { "filename", path = 1 } },
			lualine_x = { "branch", "filetype" },
			lualine_y = { "location" },
			lualine_z = { {
				"diagnostics",
				sources = { "ale", "nvim_diagnostic" },
				colored = false,
			} },
		},
		inactive_sections = {
			lualine_a = { "" },
			lualine_b = {},
			lualine_c = { { "filename", path = 1 } },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	},
}
