return {
	-- { "stevearc/dressing.nvim", opts = {} },
	{ "MunifTanjim/nui.nvim" },
	{
		"rcarriga/nvim-notify",
		opts = {
			level = vim.log.levels.WARN,
			render = "compact",
			stages = "static",
		},
	},
	{
		"folke/noice.nvim",
		opts = {
			cmdline_popup = {
				border = {
					style = "none",
					padding = { 2, 3 },
				},
				filter_options = {},
				win_options = {
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				},
			},
			presets = {
				lsp_doc_border = true,
			},
			lsp = {
				progress = {
				},
			},
			views = {
				mini = {
					backend = "mini",
					relative = "editor",
					align = "message-right",
					timeout = 2000,
					reverse = false,
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
						min_width = 60,
						width = "auto",
						height = "auto",
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = {
							Normal = "NoiceCmdlinePopup",
							FloatBorder = "NoiceCmdlinePopupBorder",
							IncSearch = "",
							CurSearch = "",
							Search = "",
						},
						cursorline = false,
					},
				},
			},
		},
		requires = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}