return {
	{
		"takac/vim-hardtime",
		init = function()
			vim.g.hardtime_default_on = 1
			vim.g.hardtime_showmsg = 1
			vim.g.hardtime_maxcount = 12
		end,
	},
}
