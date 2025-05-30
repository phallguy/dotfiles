return {
	{
		"folke/trouble.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("trouble").setup({
				mode = "document_diagnostics",
				height = 15,
				auto_close = true,
			})

			vim.keymap.set(
				"n",
				"<leader>ld",
				"<CMD>Trouble diagnostics toggle focus=false filter.buf=0<CR>",
				{ desc = "Diagnostics" }
			)
			vim.keymap.set("n", "<leader>lD", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Workspace Diagnostics" })
		end,
	},
}
