return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"zidhuss/neotest-minitest",
			"marilari88/neotest-vitest",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-vitest"),
					require("neotest-minitest"),
				},
				icons = {
					passed = "",
					running = "",
				},
				quickfix = {
					enabled = true,
					open = true,
				},
				status = {},
			})
		end,
	},
}
