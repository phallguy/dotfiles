if vim.g.vscode then
	return {}
end

return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				-- debug = true,
				-- notify = {
				-- 	view = "mini",
				-- },
				lsp = {
					signature = {
						enabled = true,
					},
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
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
								Normal = "CmdOverlay",
								FloatBorder = "CmdOverlay",
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
					{
						filter = {
							event = "msg_show",
							min_height = 10,
						},
						view = "split",
					},
				},
			})

			vim.keymap.set("n", "<leader>n", "<CMD>NoiceTelescope<CR>", { desc = "Show last notice" })
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
}
