if vim.g.vscode then
	return {}
end

return {
	{ "tpope/vim-fugitive" }, -- Git magic
	{ "tpope/vim-rhubarb" }, -- Even more git magic
	{
		"sindrets/diffview.nvim",
		opts = {
			enhanced_diff_hl = true,
			view = {
				default = {
					winbar_info = true,
				},
			},
			hooks = {
				view_entered = function(view)
				end
			}
		},
	},
}
