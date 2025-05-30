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
			dashboard = require("plugins/snacks/dashboard").config,
			picker = require("plugins/snacks/picker").config,
			image = {
				enabled = false,
			},
		},

		init = function()
			local snacks = require("snacks")

			require("plugins/snacks/picker").bindings()

			vim.keymap.set("n", "<leader>m", function()
				snacks.notifier.show_history()
			end, { desc = "Show last notice" })
		end,
	},
}
