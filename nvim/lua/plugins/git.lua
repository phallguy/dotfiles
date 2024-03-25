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
		lazy = true,
		cmd = {
			"DiffviewOpen",
			"DiffviewFileHistory",
			"DiffviewClose",
		},
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

	-- {
 --  	'SuperBo/fugit2.nvim',
 --  	opts = {},
 --  	dependencies = {
 --    	'MunifTanjim/nui.nvim',
 --    	'nvim-tree/nvim-web-devicons',
 --    	'nvim-lua/plenary.nvim',
 --    	{
 --      	'chrisgrieser/nvim-tinygit', -- optional: for Github PR view
 --      	dependencies = { 'stevearc/dressing.nvim' }
 --    	},
 --    	'sindrets/diffview.nvim' -- optional: for Diffview
 --  	},
 --  	cmd = { 'Fugit2', 'Fugit2Graph' },
 --  	build = "brew install libgit2",
	-- }
}
