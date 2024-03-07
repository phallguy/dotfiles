return {
	"petertriho/nvim-scrollbar",
	opts = {
		handlers = {
			gitsigns = true,   -- gitsigns integration (display hunks)
			ale = true,        -- lsp integration (display errors/warnings)
			search = false,    -- hlslens integration (display search result)
		},
		excluded_filetypes = {
			"cmp_docs",
			"cmp_menu",
			"noice",
			"prompt",
			"TelescopePrompt",
			"alpha",
		},
		handle = {
			text = " ",
			blend = 0, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
			color = nil,
			color_nr = nil, -- cterm
			highlight = "CursorColumn",
			hide_if_all_visible = true, -- Hides handle if all lines are visible
		},
	}
}
