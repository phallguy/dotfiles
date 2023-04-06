if vim.g.vscode then
	return {}
end

return {
	{ "jose-elias-alvarez/null-ls.nvim" },
	{
		"glepnir/lspsaga.nvim",
	},
	{
		"tzachar/cmp-fuzzy-buffer",
		dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
	},
}
