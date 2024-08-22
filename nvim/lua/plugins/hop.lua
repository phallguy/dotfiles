return {
	{
		"smoka7/hop.nvim",
		version = "*",
		config = function()
			local hop = require("hop")
			local hint = require("hop.hint")

			vim.keymap.set("n", "f", function()
				hop.hint_words({})
			end, { remap = true })

			hop.setup({
				-- keys = "jklfdsaghtybnrueiwoqpmvzxc",
				-- keys = "cxzvmpqowieurnbythgasdflkj",
				keys = "hgpmcwelkjfdas",
				uppercase_labels = true,
				x_bias = -5,
				-- reverse_distribution = true,
				jump_on_sole_occurrence = true,
				-- direction = hint.HintDirection.AFTER_CURSOR,
				dim_unmatched = false,
				hl_mode = "replace",
			})
		end,
	},
}
