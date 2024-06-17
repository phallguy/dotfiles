return {
	"stevearc/conform.nvim",
	opts = {},
	event = "BufWrite",
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({
					async = true,
					lsp_format = "fallback",
				})
			end,
			{ desc = "Format" },
		},
	},
	opts = {
		-- log_level = vim.log.levels.DEBUG,
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 2000,
			async = true,
		},
		formatters = {
			htmlbeautifier = {
				prepend_args = { "-b", "2" },
			},
			erb_format = {
				prepend_args = { "--print-width", "220" },
			},
			yamlfmt = {
				prepend_args = {},
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			json = { "fixjson" },
			javascript = { { "prettierd", "prettier" } },
			css = { { "prettierd", "prettier" } },
			sass = { { "prettierd", "prettier" } },
			scss = { { "prettierd", "prettier" } },
			html = { { "prettierd", "prettier" }, "htmlbeautifier", "injected" },
			eruby = { { "erb_format" }, { "htmlbeautifier" } },
			ruby = { "rubocop", "injected" },
			yaml = { "yamlfmt" },
			["eruby.yaml"] = { "yamlfmt" },
			svg = { "xmlformat" },

			["*"] = { "codespell", "typos" },
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
