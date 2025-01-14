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
		"xzbdmw/colorful-menu.nvim",
		config = function()
			-- You don't need to set these options.
			require("colorful-menu").setup({
				ls = {
					lua_ls = {
						-- Maybe you want to dim arguments a bit.
						arguments_hl = "@comment",
					},
					gopls = {
						-- When true, label for field and variable will format like "foo: Foo"
						-- instead of go's original syntax "foo Foo".
						add_colon_before_type = false,
					},
					["typescript-language-server"] = {
						extra_info_hl = "@comment",
					},
					["typescript-tools"] = {
						extra_info_hl = "@comment",
					},
					ts_ls = {
						extra_info_hl = "@comment",
					},
					tsserver = {
						extra_info_hl = "@comment",
					},
					vtsls = {
						extra_info_hl = "@comment",
					},
					["rust-analyzer"] = {
						-- Such as (as Iterator), (use std::io).
						extra_info_hl = "@comment",
					},
					clangd = {
						-- Such as "From <stdio.h>".
						extra_info_hl = "@comment",
					},
					roslyn = {
						extra_info_hl = "@comment",
					},
					basedpyright = {
						extra_info_hl = "@comment",
					},

					-- If true, try to highlight "not supported" languages.
					fallback = true,
				},
				-- If the built-in logic fails to find a suitable highlight group,
				-- this highlight is applied to the label.
				fallback_highlight = "@variable",
				-- If provided, the plugin truncates the final displayed text to
				-- this width (measured in display cells). Any highlights that extend
				-- beyond the truncation point are ignored. Default 60.
				max_width = 60,
			})
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
