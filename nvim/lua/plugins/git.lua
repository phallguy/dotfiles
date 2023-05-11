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
				merge_tool = {
					layout = "diff3_mixed"
				}
			},
			hooks = {
				diff_buf_win_enter = function(bufnr)
					vim.keymap.set("n", "q", "<CMD>DiffviewClose<CR>", { buffer = bufnr })
				end,
			},
			keymaps = {
				file_panel = {
					q = "<CMD>DiffviewClose<CR>"
				}
			}
		},
	},
}
