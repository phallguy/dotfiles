return {
	{
		"takac/vim-hardtime",
		enabled = false,
		init = function()
			vim.g.hardtime_default_on = 1
			vim.g.hardtime_showmsg = 1
			vim.g.hardtime_maxcount = 20
			vim.g.list_of_normal_keys = { "j", "k", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
			vim.g.list_of_visual_keys = {}
			vim.g.hardtime_ignore_quickfix = 1
			vim.g.hardtime_ignore_buffer_patterns = {
				"help",
				"doc/*",
				"markdown",
				"neo-tree",
			}
		end,
	},
}
