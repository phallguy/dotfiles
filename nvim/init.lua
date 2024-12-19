-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- THICC borders, here to avoid flash of tilds on start
vim.opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
	eob = " ",
}

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
	spec = {
		-- NOTE: First, some plugins that don't require any configuration

		-- import .vimrc from CWD when launching
		{
			"embear/vim-localvimrc",
			config = function() end,
		},

		{ import = "plugins/colorschemes" },
		{ import = "plugins" },
	},

	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	rocks = {
		enabled = false,
	},
	ui = {
		-- border = "shadow",
	},
	checker = {
		-- Look for plugin updates
		enabled = false,
	},
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

require("user.colorscheme")
require("user.editing")
require("user.session")
require("user.highlight_on_yank")
require("user.terminal")
require("user.git")

require("user.html")
require("user.ruby")
require("user.markdown")

require("user.testing")
require("user.lsp")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
