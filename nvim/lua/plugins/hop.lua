return {
	{
		"smoka7/hop.nvim",
		version = "*",
		config = function()
			local hop = require("hop")

			vim.keymap.set("n", "f", function()
				hop.hint_words({})
			end, { remap = true })

			hop.setup({
				keys = "jklfdsaghtybnrueiwoqpmv",
				uppercase_labels = true,
				x_bias = 100,
				jump_on_sole_occurrence = true,
				dim_unmatched = false,
				hl_mode = "replace",
			})
		end,
	},
}
