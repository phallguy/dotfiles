return {
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				mode = "document_diagnostics",
				height = 15,
				auto_close = true,
			})

			vim.keymap.set("n", "<leader>ld", "<CMD>TroubleToggle document_diagnostics<CR>", { desc = "Diagnostics" })
		end,
	},
}
