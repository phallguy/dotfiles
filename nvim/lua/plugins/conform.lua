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
	},
	opts = {
		-- log_level = vim.log.levels.DEBUG,
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end

			local ignore_filetypes = { "yaml" }
			if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
				return
			end

			-- Disable autoformat for files in a certain path
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if bufname:match("/node_modules/") then
				return
			end

			return {
				lsp_format = "fallback",
				timeout_ms = 500,
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
			coffee = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			css = { { "prettierd", "prettier" } },
			sass = { { "prettierd", "prettier" } },
			scss = { { "prettierd", "prettier" } },
			html = { { "prettierd", "prettier" }, "htmlbeautifier", { "typos" }, { "codespell" } },
			eruby = { { "htmlbeautifier" }, { "typos" }, { "codespell" } },
			ruby = { { "rubocop" }, { "typos" }, { "odespell" } },
			yaml = { { "yamlfmt" } },
			["eruby.yaml"] = { "yamlfmt" },
			svg = { "xmlformat" },
		},
	},
	init = function()
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

		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
