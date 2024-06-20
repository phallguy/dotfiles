return {
	{
		"stevearc/oil.nvim",
		enabled = false,
		opts = {
			delete_to_trash = true,
			keymaps = {
				["<C-v>"] = {
					"actions.select",
					opts = { vertical = true },
					desc = "Open the entry in a vertical split",
				},
				["gq"] = {
					function()
						local oil = require("oil")
						local entry = oil.get_cursor_entry()
						local dir = oil.get_current_dir()
						if not entry or not dir then
							return
						end
						local path = dir .. entry.name

						vim.cmd(("silent !qlmanage -p %s &"):format(path))
					end,
					desc = "Open quick preview",
				},
				["q"] = "actions.close",
				["H"] = "actions.toggle_hidden",
			},
		},
		keys = {
			-- {
			-- 	"-",
			-- 	"<CMD>Oil<CR>",
			-- 	{
			-- 		desc = "Open parent dir",
			-- 	},
			-- },
		},
		cmd = {
			"Oil",
		},
	},
}
