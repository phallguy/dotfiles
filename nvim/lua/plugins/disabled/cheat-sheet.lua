return {
	{
		"RishabhRD/nvim-cheat.sh",
		-- event = "VeryLazy",
		cmd = { "Cheat" },

		keys = {
			{
				"<leader>fh",
				function()
					local word = vim.fn.expand("<cword>")
					vim.cmd("Cheat " .. vim.bo.filetype .. " " .. word)
				end,
				{ desc = "Cheat sheet" },
			},
		},
		dependencies = { "RishabhRD/popfix" },
		config = function()
			vim.g.cheat_default_window_layout = "vertical_split"

			require("nvim-cheat")
		end,
	},
}
