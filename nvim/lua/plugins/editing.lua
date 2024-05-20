if vim.g.vscode then
	return {}
end

vim.g.loaded_matchit = 1

return {
	-- Useful plugin to show you pending keybinds.

	-- -- "gc" to comment visual regions/lines
	-- {
	-- 	"numToStr/Comment.nvim",
	-- 	opts = {},
	-- },


	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		event = "VeryLazy",
		opts = {},
	},


	-- Multi cursors
	{
		"mg979/vim-visual-multi",
		event = "BufEnter"
	},


	{
		"reedes/vim-pencil",
		cmd = {
			"Pencil",
			"PencilSoft"
		},
		config = function()
			vim.g["pencil#wrapModeDefault"] = "soft"
		end,
	},

	{
		"junegunn/goyo.vim",
		cmd = { "Goyo" }
	},

	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require('nvim-highlight-colors').setup {
				enable_named_colors = false,
			}
		end
	},

	{
		"sheerun/vim-polyglot",
		priority = 500,
		cond = not vim.g.vscode,
		init = function()
			-- vim.g.polyglot_disabled = { "autoindent", "sensible", "ftdetect" }
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
	},

}
