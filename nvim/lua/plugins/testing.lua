vim.g.dispatch_no_maps = 1

return {
	{
		"vim-test/vim-test",
		event = "BufEnter",
	},

	-- Async test runner to quick fix
	{
		"tpope/vim-dispatch",
		event = "VeryLazy"
	},
}
