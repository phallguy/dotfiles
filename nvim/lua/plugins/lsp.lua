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
	{
		"ludovicchabant/vim-gutentags",
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function ()
			require("lsp_signature").setup({
				bind = true,
				noice = true,
				handler_opts = {
					border = "rounded"
				}
			})
		end,
	}
}
