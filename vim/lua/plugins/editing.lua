if vim.g.vscode then
	return {}
end

return {
	-- "tpope/vim-vinegar", -- netwr support

	-- Useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim", opts = {} },

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
			vim.opt.termguicolors = true -- True color support
			require("colorizer").setup({
				"*",
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
			-- vim.g.polyglot_disabled = { "autoindent" }
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
}
