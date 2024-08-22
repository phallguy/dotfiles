return {
	{
		"stevearc/overseer.nvim",
		keys = {
			{
				"<leader>k",
				function()
					local util = require("user.util")
					util.invoke_cmd_with_cursor(function()
						require("overseer").toggle({ enter = true })
					end)
				end,
				{ desc = "Toggle overseer" },
			},
		},
		opts = {
			auto_detect_success_color = false,
			dap = false,
			-- strategy = {
			-- 	"terminal",
			-- },
			task_list = {
				bindings = {
					["<C-l>"] = false,
					["<C-h>"] = false,
					["<space>"] = "IncreaseDetail",
					["-"] = "DecreaseDetail",
					["<C-d>"] = "ScrollOutputDown",
					["<C-u>"] = "ScrollOutputUp",
					["o"] = false,
				},
				max_width = { 1500, 1.0 },
				min_width = { 80, 0.50 },
				min_height = { 15, 0.10 },
				default_detail = 2,
			},

			form = {
				win_opts = {
					winblend = 5,
				},
			},

			component_aliases = {
				default_neotest = {
					{ "display_duration", detail_level = 2 },
					"on_output_summarize",
					"on_exit_set_status",
					"on_complete_notify",
					"on_complete_dispose",
					"on_result_diagnostics",
				},
			},
		},
	},
}
