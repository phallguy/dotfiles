return {
	-- Code folding
	{
		"kevinhwang91/nvim-ufo",
		enabled = false,
		dependencies = "kevinhwang91/promise-async",
		config = function()
			vim.foldcolumn = "1" -- '0' is not bad
			vim.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.foldlevelstart = 99
			vim.foldenable = true

			-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

			require("ufo").setup({})
		end,
	},
}
