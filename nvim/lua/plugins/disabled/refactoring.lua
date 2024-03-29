return {
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
			{ "nvim-telescope/telescope.nvim" }
		},
		config = function()
			require('refactoring').setup({})
			-- load refactoring Telescope extension
			require("telescope").load_extension("refactoring")

			-- remap to open the Telescope refactoring menu in visual mode
			vim.api.nvim_set_keymap(
				"v",
				"<leader>rr",
				"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
				{ noremap = true }
			)
		end
	}
}
