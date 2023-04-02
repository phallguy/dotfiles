if vim.g.vscode then
	return {}
end

return {
	-- { "stevearc/dressing.nvim", opts = {} },
	{ "MunifTanjim/nui.nvim" },
	{
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				-- debug = true,
				notify = {
					view = "mini",
				},
				views = {
					mini = {
						backend = "mini",
						relative = "editor",
						align = "message-right",
						timeout = 3000,
						reverse = true,
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
							winhighlight = {
								Normal = "NoiceMini",
								IncSearch = "",
								CurSearch = "",
								Search = "",
							},
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
							padding = { 2, 5 },
						},
						win_options = {
							winhighlight = {
								Normal = "NormalOverlay",
								FloatBorder = "FloatBorder",
							}
							-- cursorline = false,
						},
					},
				},
				routes = {
					{
						filter = {
							event = "lsp",
							kind = "progress",
							find = "code_action",
						},
						opts = { stop = true, skip = true },
					},
					{
						filter = {
							event = "lsp",
							kind = "progress",
							find = "iagnos",
						},
						opts = { stop = true, skip = true },
					},
					-- {
					-- 	filter = {
					-- 		event = "msg_show",
					-- 		kind = "",
					-- 		find = { "change;", "line less;", "lines less;", "more line;", "more lines;", "changes;" },
					-- 	},
					-- 	opts = { stop = true, skip = true },
					-- },
					-- {
					-- 	filter = {
					-- 		event = "notify",
					-- 		min_height = 10,
					-- 	},
					-- 	view = "split",
					-- },
					-- {
					-- 	filter = {
					-- 		event = "msg_show",
					-- 		min_height = 10,
					-- 	},
					-- 	view = "split",
					-- },
				},
			})

			vim.keymap.set("n", "<leader>n", "<CMD>NoiceTelescope<CR>", { desc = "Show last notice" })
		end,
		requires = {
			"MunifTanjim/nui.nvim",
		},
	},
}
