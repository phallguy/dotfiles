return {
	"petertriho/nvim-scrollbar",
	event = "BufEnter",
	opts = {
		handlers = {
			gitsigns = false, -- gitsigns integration (display hunks)
			ale = false,   -- lsp integration (display errors/warnings)
			search = true, -- hlslens integration (display search result)
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
			blend = 70,              -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
			color = nil,
			color_nr = nil,          -- cterm
			-- highlight = nil,
			highlight = "ScrollbarThumb",
			hide_if_all_visible = true, -- Hides handle if all lines are visible
		},
		marks = {
			Cursor = {
				text = " ",
				priority = 0,
				gui = nil,
				color = nil,
				cterm = nil,
				color_nr = nil, -- cterm
				highlight = "Normal",
			},
		}
	}
}
