return {
	"petertriho/nvim-scrollbar",
	opts = {
		show_in_active_only = true,
		excluded_filetypes = {
			"cmp_docs",
			"cmp_menu",
			"noice",
			"prompt",
			"TelescopePrompt",
			"alpha",
		},
		handlers = {
			cursor = false,
		},
		handle = {
			text = " ",
			hide_if_all_visible = true, -- Hides handle if all lines are visible
		},
	},
}
