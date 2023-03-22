return {
	{
		"numToStr/FTerm.nvim",
		opts = {},
		config = function()
			require("FTerm").setup({
				cmd = "bash -il",
				border = "none",
				hl = "NormalFloat",
				dimensions = {
					height = 0.45,
					width = 1,
					x = 0.5,
					y = 1,
				}
			})

			vim.api.nvim_create_user_command("Te", require("FTerm").toggle, { desc = "Toggle terminal" })
			vim.keymap.set({ "n", "i", "t" }, "<A-t>", require("FTerm").toggle, { desc = "Toggle terminal" })
		end,
	},
}
