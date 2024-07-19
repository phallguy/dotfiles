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
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "  ", right = "" },
				section_separators = { right = " ", left = "" },
			},
			sections = {
				lualine_a = {
					{ "branch", icon = icons.git.Branch },
				},
				lualine_b = { { "filetype", padding = 1, draw_empty = true } },
				lualine_c = {
					{
						"filename",
						path = 1,
						newfile_status = true,
						symbols = {
							modified = "",
							readonly = "",
						},
					},
				},
				lualine_x = {
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

							return tostring(timer) .. " "
						end,
						draw_empty = true,
					},
				},
				lualine_y = { { "location", padding = { right = 1 } } },
				lualine_z = {
					{
						"diagnostics",
						-- sources = { "nvim_diagnostic" },
						colored = false,
					},
					{
						"reg_recording",
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
