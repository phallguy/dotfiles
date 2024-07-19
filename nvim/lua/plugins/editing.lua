if vim.g.vscode then
	return {}
end

vim.g.loaded_matchit = 1

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
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},

	{
		"tpope/vim-projectionist",
		event = "BufEnter",
		dependencies = {
			"sheerun/vim-polyglot",
			"tpope/vim-rails",
		},
		init = function()
			vim.g.projectionist_vim_enter = 1
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
