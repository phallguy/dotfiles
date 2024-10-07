if vim.g.vscode then
	return {}
end

return {
	-- Multi cursors
	{
		"mg979/vim-visual-multi",
		event = "InsertEnter",
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
		"junegunn/goyo.vim",
		cmd = { "Goyo" },
	},

	{
		"sheerun/vim-polyglot",
		priority = 500,
		cond = not vim.g.vscode,
		init = function()
			vim.g.polyglot_disabled = { "autoindent", "sensible", "ftdetect" }
		end,
	},

	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_deferred = 1 -- work async
			vim.g.matchup_matchparen_offscreen = {}
			vim.g.matchup_matchparen_stopline = 1000
		end,
	},

	{
		"tpope/vim-projectionist",
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
