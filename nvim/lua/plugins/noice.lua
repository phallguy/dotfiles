if vim.g.vscode then
	return {}
end

return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				-- debug = true,
				notify = {
					view = "mini",
				},
				lsp = {
					signature = {
						enabled = false,
					},
				},
				views = {
					mini = {
						backend = "mini",
						relative = "editor",
						align = "message-right",
						timeout = 3000,
						-- reverse = true,
						focusable = false,
						position = {
							row = -1,
							col = "100%",
							-- col = 0,
						},
						size = "auto",
						border = {
							style = "none",
						},
						zindex = 60,
						win_options = {
							winblend = 0,
							-- winhighlight = {
							-- 	Normal = "NoiceMini",
							-- 	IncSearch = "",
							-- 	CurSearch = "",
							-- 	Search = "",
							-- },
						},
					},
					cmdline_popup = {
						backend = "popup",
						relative = "editor",
						focusable = false,
						enter = false,
						zindex = 60,
						position = {
							row = "50%",
							col = "50%",
						},
						size = {
							min_width = 60,
							width = "auto",
							height = "auto",
						},
						border = {
							style = "none",
							padding = { 2, 4 },
						},
					},
				},
			})

			vim.keymap.set("n", "<leader>m", "<CMD>NoiceTelescope<CR>", { desc = "Show last notice" })
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"MunifTanjim/nui.nvim",
		lazy = true,
	},
}
