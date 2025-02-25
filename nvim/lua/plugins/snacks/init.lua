return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			notifier = {
				enabled = true,
				top_down = false,
				margin = { bottom = 1 },
			},
			notify = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			debug = { enabled = true },
			gitbrowse = { enabled = true },
			input = {
				enabled = true,
			},
			dashboard = require("plugins/snacks/dashboard"),
			picker = {
				layout = "mivy",
				layouts = {
					mivy = {
						layout = {
							box = "vertical",
							backdrop = false,
							row = -1,
							width = 0,
							height = 0.4,
							border = "top",
							title = " {title} {live} {flags}",
							title_pos = "left",
							{
								box = "horizontal",
								{ win = "list", border = "none" },
								{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
							},
							{ win = "input", height = 1, border = "top" },
						},
					},
				},
			},
		},

		init = function()
			local snacks = require("snacks")

			vim.keymap.set("n", "<leader>m", function()
				snacks.notifier.show_history()
			end, { desc = "Show last notice" })

			require("plugins/snacks/picker")
		end,
	},
}
