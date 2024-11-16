if vim.g.vscode then
	return {}
end

return {
	{
		"tpope/vim-projectionist",
	},

	{
		"reedes/vim-pencil",
		cmd = {
			"Pencil",
			"PencilSoft",
		},
		config = function()
			vim.g["pencil#wrapModeDefault"] = "soft"
		end,
	},

	{
		"sheerun/vim-polyglot",
		cond = not vim.g.vscode,
		init = function()
			vim.g.polyglot_disabled = { "autoindent", "sensible", "ftdetect" }
		end,
	},

	{
		"andymass/vim-matchup",
		config = function()
			-- vim.g.matchup_matchparen_deferred = 1 -- work async
			vim.g.matchup_matchparen_offscreen = {}
			vim.g.matchup_matchparen_stopline = 1000
		end,
	},

	{
		"kjuq/sixelview.nvim",
		keys = {
			{
				"<leader>gp",
				"<CMD>SixelView<CR>",
				{ "Preview image" },
			},
		},
		cmd = {
			"SixelView",
		},
		opts = {
			auto = false,
		},
	},
}
