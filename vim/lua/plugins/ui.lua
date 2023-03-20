return {
	-- { "stevearc/dressing.nvim", opts = {} },
	{ "MunifTanjim/nui.nvim" },
	{
		"rcarriga/nvim-notify",
		opts = {
			-- level = vim.log.levels.WARN,
			render = "compact",
			stages = "static",
		},
	},
	{},
	{
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				debug = false,
				presets = {
					lsp_doc_border = true,
				},
				views = {
					mini = {
						backend = "mini",
						relative = "editor",
						align = "message-right",
						timeout = 1000,
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
							winblend = 100,
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
							row = "75%",
							col = "50%",
						},
						size = {
							min_width = 80,
							width = "auto",
							height = "auto",
						},
						border = {
							style = "none",
							padding = { 2, 5 },
						},
						win_options = {
							winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
							cursorline = false,
						},
					},
				},
				routes = {
					{
						filter = {
							event = "lsp",
							kind = "progress",
							find = "diagnostics",
						},
						opts = { stop = true, skip = true },
					},
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "[noeol]",
						},
						opts = { stop = true, skip = true },
					}
				},
			})
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}
