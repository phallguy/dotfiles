return {
	{ "tpope/vim-fugitive" }, -- Git magic
	{ "tpope/vim-rhubarb" }, -- Even more git magic
	{ "pwntester/octo.nvim" }, -- Github magic
	{
		"sindrets/diffview.nvim",
		opts = {
			enhanced_diff_hl = true,
			view = {
				default = {
					winbar_info = true,
				},
			},
		},
	},
}
