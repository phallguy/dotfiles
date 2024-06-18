return {
	"stevearc/conform.nvim",
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
	cmd = {
		"Conform",
		"ConformInfo",
		"FormatEnable",
		"FormatDisable",
	},
	opts = {
		-- log_level = vim.log.levels.DEBUG,
		format_after_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end

			return {
				lsp_format = "fallback",
				timeout_ms = 500,
				async = true,
			}
		end,
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

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})
		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end,
}
