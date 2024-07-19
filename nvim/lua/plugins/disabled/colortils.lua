return {
	{
		"max397574/colortils.nvim",
		cmd = "Colortils",
		config = function()
			require("colortils").setup({
				mappings = {
					-- save the current color in the register specified above with the format specified above
					set_register_default_format = "<s-cr>",
					-- save the current color in the register specified above with a format you can choose
					set_register_choose_format = "g<s-cr>",
					-- replace the color under the cursor with the current color in the format specified above
					replace_default_format = "<cr>",
					-- replace the color under the cursor with the current color in a format you can choose
					replace_choose_format = "g<cr>",
				},
			})
		end,
	},
}
