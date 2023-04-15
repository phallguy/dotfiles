if vim.g.vscode then
	return {}
end

return {
	{ "tpope/vim-fugitive" }, -- Git magic
	{ "tpope/vim-rhubarb" }, -- Even more git magic
	{
		-- https://github.com/sindrets/diffview.nvim
		"sindrets/diffview.nvim",
		opts = {
			enhanced_diff_hl = true,
			view = {
				default = {
					winbar_info = true,
				},
			},
			hooks = {
				view_enter = function()
					vim.keymap.set("n", "<leader>c", "<CMD>DiffviewClose<CR>")
					vim.keymap.set("n", "q", "<CMD>DiffviewClose<CR>")
				end,
				view_leave = function()
					pcall(vim.keymap.del, "n", "<leader>c")
					pcall(vim.keymap.del ,"n", "q")
				end
			}
		},
	},
}
