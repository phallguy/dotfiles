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
		"junegunn/goyo.vim",
		cmd = {
			"Goyo",
		},
	},

	{
		"sheerun/vim-polyglot",
		cond = not vim.g.vscode,
		init = function()
			vim.g.polyglot_disabled = { "autoindent", "sensible", "ftdetect" }
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
