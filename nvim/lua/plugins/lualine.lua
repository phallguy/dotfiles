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
				theme = "rose-pine",
				component_separators = { left = "  ", right = "" },
				section_separators = { right = " ", left = "" },
			},
			extensions = {
				"quickfix",
				"overseer",
				"neo-tree",
			},
			sections = {
				lualine_a = {
					{
						"filename",
						path = 0,
						newfile_status = true,
						shorting_target = 150,
						symbols = {
							modified = "",
							readonly = "",
							new = "",
						},
					},
				},
				lualine_b = {
					{
						"%{expand('%:~:.:h')}",
					},
				},
				lualine_c = {
					{ "filetype", padding = 1, draw_empty = false, component_separators = false },
					{ "overseer", status = { "RUNNING" }, component_separators = false },
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
					},
					{ "branch", icon = icons.git.Branch },
				},
				lualine_y = {
					{ "location", padding = { left = 1 } },
				},
				lualine_z = {
					{
						"diagnostics",
						-- sources = { "nvim_diagnostic" },
						colored = false,
						component_separators = false,
					},
					{
						function()
							if not require("lazy.core.config").plugins["neotest"]._.loaded then
								return ""
							end

							local state = require("neotest.consumers.state")
							if not state then
								return ""
							end

							local buffer = vim.fn.bufnr()
							local total = 0
							local running = 0
							local passed = 0

							for _, adapter_id in pairs(state.adapter_ids()) do
								local counts = state.status_counts(adapter_id, { buffer = buffer })
								if counts then
									total = total + counts.total
									running = running + counts.running
									passed = passed + counts.passed
								end
							end

							if total <= 0 then
								return ""
							end

							local status = ""

							if running > 0 then
								status = status .. "%#NeotestStatusRunning#" .. icons.test.running .. " " .. running
							end

							if passed > 0 then
								if string.len(status) > 0 then
									status = status .. " "
								end

								status = status .. "%#NeotestStatusPassed#" .. icons.test.passed .. " " .. passed
							end

							return status
						end,
						draw_empty = true,
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
