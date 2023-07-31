if vim.g.vscode then
	return {}
end

return {
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		cond = not vim.g.vscode,
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{
				"williamboman/mason.nvim",
				build = ":MasonUpdate",
			},
			"williamboman/mason-lspconfig.nvim",

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
	},
	{
		"glepnir/lspsaga.nvim",
	},
}
