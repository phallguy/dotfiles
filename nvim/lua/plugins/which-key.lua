return {
	"folke/which-key.nvim",
	enabled = true,
	event = "VeryLazy",
	opts = {
		-- marks = false,
		-- registers = false,
		presets = {
			-- operators = false,
			-- motions = false,
		},
		triggers_blacklist = {
			n = { "g", "gf" },
		},
	},
}
