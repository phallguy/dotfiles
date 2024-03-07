return {
	"folke/which-key.nvim",
	enabled = false,
	opts = {
		marks = false,
		registers = false,
		presets = {
			operators = false,
			motions = false,
		},
		triggers_blacklist = {
			n = { "g", "gf" },
		},
	},
}
