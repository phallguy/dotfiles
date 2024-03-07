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

			vim.keymap.set("n", "<leader>ld", "<CMD>TroubleToggle document_diagnostics<CR>", { desc = "Diagnostics" })
			vim.keymap.set("n", "<leader>lD", "<CMD>TroubleToggle workspace_diagnostics<CR>", { desc = "Workspace Diagnostics" })
		end,
	},
}
