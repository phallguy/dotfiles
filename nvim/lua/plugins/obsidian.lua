return {
	{
		"epwalsh/obsidian.nvim",
		ft = { "markdown" },
		cmd = { "ObsidianOpen", "ObsidianNew", "ObsidianTags" },
		lazy = true,
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
		},
		-- ~/paul.xheo@gmail.com - Google Drive/My Drive/Obsidian Vault 01:12:11 PM
		opts = {
			workspaces = {
				{
					name = "personal",
					path = vim.fn.expand("~/paul.xheo@gmail.com - Google Drive/My Drive/Obsidian Vault"),
				},
			},

			daily_notes = {
				folder = "Personal/Daily",
			},

			follow_url_func = function(url)
				vim.fn.jobstart({ "open", url }) -- Mac OS
			end,
		},
		keys = {
			{ "<leader>nt", "<cmd>ObsidianTags<CR>", { desc = "Search note tags" } },
		},
	},
	{
		"nvim-telekasten/telekasten.nvim",
		opts = {
			home = vim.fn.expand("~/paul.xheo@gmail.com - Google Drive/My Drive/Obsidian Vault"),
			dailies = vim.fn.expand("~/paul.xheo@gmail.com - Google Drive/My Drive/Obsidian Vault/Personal/Daily"),
			templates = vim.fn.expand("~/paul.xheo@gmail.com - Google Drive/My Drive/Obsidian Vault/.templates"),
			journal_auto_open = true,
		},
		keys = {
			{ "<leader>n", "<cmd>Telekasten panel<CR>", { desc = "Notes panel" } },

			{ "<leader>fn", "<cmd>Telekasten search_notes<CR>", { desc = "Search notes" } },
			-- { "<leader>nt", "<cmd>Telekasten toggle_todo<CR>", { desc = "Toggle todo" } },
			{ "<leader>nn", "<cmd>Telekasten goto_today<CR>", { desc = "Go to today" } },
			{ "<leader>nc", "<cmd>Telekasten show_calendar<CR>", { desc = "Notes calendar" } },
			{ "<leader>nC", "<cmd>CalendarT<CR>", { desc = "Notes calendar" } },
			{ "<leader>nv", "<cmd>Telekasten switch_vault<CR>", { desc = "Switch vault" } },
			-- vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
			-- vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")
			--
			-- -- Call insert link automatically when we start typing a link
			{ "[[", "<cmd>Telekasten insert_link<CR>", { mode = { "i", "n" }, desc = "Insert link" } },
		},
	},
	{
		"nvim-telekasten/calendar-vim",
		cmd = { "Calendar", "CalendarT", "CalendarH", "CalendarVR" },
	},
}
