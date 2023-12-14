local icons = require("user.icons")

require("lspsaga").setup({
	request_timeout = 30000,
	symbol_in_winbar = {
		enable = false,
		show_file = false,
	},
	definition = {
		edit = "<CR>",
	},
	outline = {
		auto_close = true,
		keys = {
			toggle_or_jump = "<CR>",
		},
	},
	lightbulb = {
		enable = true,
		enable_in_insert = false,
		sign = true,
		sign_priority = 40,
		virtual_text = false,
	},
	diagnostic = {
		-- don't show in-flight analysis in upper right
		on_insert = false,
		show_virt_line = false,
		-- border_follow = false,
	},
	finder = {
		request_timeout = 10000,
		keys = {
			toggle_or_open = "<CR>",
			vsplit = { "<C-v>", "v" },
			split = { "s" },
		},
	},
	-- lightbulb = {
	--   show_virt_line = false
	-- },
	beacon = {
		frequency = 3,
	},
	ui = {
		title = false,
		border = "rounded",
		code_action = icons.diagnostics.Hint,
	},
	code_actions = {
		show_server_name = true,
		extend_gitsigns = true,
	}
})
