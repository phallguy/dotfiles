return {
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
	},

	{
		"hrsh7th/nvim-cmp",
		-- enabled = false,
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
			"petertriho/cmp-git",
		},
		config = function()
			require("user.completion-nvim-cmp")
		end,
	},
	{
		"saghen/blink.cmp",
		enabled = false,
		lazy = false, -- lazy loading handled internally
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
		},

		-- use a release tag to download pre-built binaries
		version = "v0.*",
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		config = function()
			require("user.completion-blink-cmp")
		end,
		-- allows extending the providers array elsewhere in your config
		-- without having to redefine it
		-- opts_extend = { "sources.default", "sources.providers", "snippets" },
	},
}
