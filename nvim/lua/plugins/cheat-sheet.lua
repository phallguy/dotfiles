return {
	{
		"RishabhRD/nvim-cheat.sh",
		-- event = "VeryLazy",
		cmd = { "Cheat" },
		dependencies = { "RishabhRD/popfix" },
		config = function()
			vim.g.cheat_default_window_layout = 'vertical_split'

			require("nvim-cheat")
		end
	}
}
