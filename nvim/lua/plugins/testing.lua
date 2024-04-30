vim.g.dispatch_no_maps = 1
vim.g.dispatch_compilers = { ['bundle exec'] = '' }

return {
	{
		"vim-test/vim-test",
		dependencies = {
			"tpope/vim-dispatch",
		}
	},

	-- Async test runner to quick fix
	{
		"tpope/vim-dispatch",
	},
}
