if vim.g.vscode then
	return {}
end

vim.g.loaded_matchit = 1

return {
	-- "tpope/vim-vinegar", -- netwr support

	-- Useful plugin to show you pending keybinds.
	{
		"folke/which-key.nvim",
		opts = {
			triggers_blacklist = {
				n = { "g", "gf" },
			},
		},
	},

	-- "gc" to comment visual regions/lines
	{
		"numToStr/Comment.nvim",
		opts = {},
	},

	{ "nvim-tree/nvim-web-devicons", opts = {} },

	{ "mg979/vim-visual-multi" }, -- Multi cursors
	{ "junegunn/vim-easy-align" }, -- Multi-line bock alignment
	{ "tpope/vim-surround" }, -- change surrounding tags/quotes/parens
	{
		"reedes/vim-pencil",
		config = function()
			vim.g["pencil#wrapModeDefault"] = "soft"
		end,
	},
	{ "AndrewRadev/splitjoin.vim" },
	-- { "mbbill/undotree" },
	{
		"norcalli/nvim-colorizer.lua",
		cond = not vim.g.vscode,
		config = function()
			require("colorizer").setup({
				ruby = {
					css = false,
					RGB = false,
				},
			}, {
				css = true,
			})
		end,
	},
	{ "KabbAmine/vCoolor.vim" },

	{
		"sheerun/vim-polyglot",
		cond = not vim.g.vscode,
		init = function()
			-- vim.g.polyglot_disabled = { "autoindent", "sensible", "ftdetect" }
		end,
		priority = 10,
	},
	{
		"andymass/vim-matchup",
		config = function()
			-- may set any options here
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},

	{
		"kazhala/close-buffers.nvim",
		opts = {
			preserve_window_layout = { "this" },
		},
	},

	{ "tpope/vim-projectionist" },
}
