return {
	"stevearc/conform.nvim",
	event = "BufWrite",
	keys = {
		{
			"<leader>lF",
			function()
				require("conform").format({
					async = true,
					lsp_format = "fallback",
				})
			end,
			desc = "Format",
		},
		{
			"<leader>lF",
			"<CMD>Format<CR>",
			mode = "v",
			desc = "Format selection",
		},
	},
	cmd = {
		"Conform",
		"ConformInfo",
	},
	opts = {
		-- log_level = vim.log.levels.DEBUG,
		default_format_opts = {},
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
				lsp_format = "never",
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
			-- yamlfmt = {
			-- 	prepend_args = {},
			-- },
		},
		formatters_by_ft = {
			lua = { "stylua" },
			json = { "fixjson" },
			javascript = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
			css = { "prettierd", "prettier" },
			sass = { "prettierd", "prettier" },
			scss = { "prettierd", "prettier" },
			html = { "prettierd", "prettier", "htmlbeautifier" },
			eruby = { "htmlbeautifier" },
			ruby = { "rubocop" },
			-- yaml = { "yamlfmt" },
			-- ["eruby.yaml"] = { "yamlfmt" },
			sg = { "xmlformat" },
		},
	},
	init = function()
		vim.api.nvim_create_user_command("FD", function(args)
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

		vim.api.nvim_create_user_command("FE", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})

		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end
			require("conform").format({ async = true, lsp_format = "never", range = range })
		end, { range = true })

		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
