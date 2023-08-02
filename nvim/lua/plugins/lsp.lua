if vim.g.vscode then
	return {}
end

return {
	{
		"neovim/nvim-lspconfig",
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"folke/neodev.nvim",
		config = {}
	},
	{
		"glepnir/lspsaga.nvim",
	},
	{
		"MunifTanjim/prettier.nvim",
	}
}
