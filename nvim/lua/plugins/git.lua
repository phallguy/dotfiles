if vim.g.vscode then
	return {}
end

return {
	-- Git magic
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
	},

	-- Even more git magic
	{
		"tpope/vim-rhubarb",
		event = "VeryLazy",
	},

	{
		-- https://github.com/sindrets/diffview.nvim
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewFileHistory",
			"DiffviewClose",
		},
		opts = {
			enhanced_diff_hl = true,
			DiffviewOpen = { "--imply-local" },
			view = {
				default = {
					winbar_info = true,
					disable_diagnostics = true,
				},
				merge_tool = {
					layout = "diff3_mixed",
				},
			},
			hooks = {
				diff_buf_win_enter = function(bufnr)
					vim.keymap.set("n", "q", "<CMD>DiffviewClose<CR>", { buffer = bufnr })
				end,
			},
			keymaps = {
				file_panel = {
					q = "<CMD>DiffviewClose<CR>",
				},
			},
		},
	},
}
