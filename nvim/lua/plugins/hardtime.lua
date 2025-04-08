return {
	{
		"takac/vim-hardtime",
		-- enabled = false,
		init = function()
			vim.g.hardtime_default_on = 1
			vim.g.hardtime_showmsg = 1
			vim.g.hardtime_maxcount = 10
			vim.g.list_of_normal_keys = { "h", "j", "k", "l", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
			vim.g.list_of_visual_keys = {}
		end,
	},
}
