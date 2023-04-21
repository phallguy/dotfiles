-- Old vim https://github.com/phallguy/dotfiles/blob/6f512c6a40be13df2a27a9df0d6c4af28cd82c0b/vim/init.vim
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("user.options")

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g["localvimrc_name"] = { ".lvimrc", ".vimrc" }
vim.g["localvimrc_sandbox"] = 0
vim.g["localvimrc_persistent"] = 2
vim.g["localvimrc_debug"] = 4

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require("lazy").setup({
	-- NOTE: First, some plugins that don't require any configuration

	-- import .vimrc from CWD when launching
	{
		"embear/vim-localvimrc",
		config = function() end,
	},

	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		cond = not vim.g.vscode,
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
	},

	{ "tzachar/fuzzy.nvim", dependencies = { "nvim-telescope/telescope-fzf-native.nvim" } },

	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		cond = not vim.g.vscode,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"petertriho/cmp-git",
			"onsails/lspkind.nvim",
		},
	},

	{ import = "plugins" },
}, {
	ui = {
		border = "rounded",
	},
	checker = {
		enabled = true,
	},
	change_detection = {
		enabled = false,
		notify = true,
	},
})

require("user.editing")
require("user.session")
require("user.netwr")
require("user.hilight_on_yank")
require("user.terminal")
require("user.git")

require("user.html")
require("user.ruby")

require("user.testing")
require("user.lsp")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
