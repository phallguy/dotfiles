vim.g.splitjoin_ruby_curly_braces = 0
vim.g.splitjoin_ruby_hanging_args = 0
vim.g.splitjoin_ruby_trailing_comma = 1
vim.g.splitjoin_normalize_whitespace = 1
vim.g.splitjoin_align = 1
vim.g.splitjoin_ruby_options_as_arguments = 1
vim.g.splitjoin_trailing_comma = 1

return {
	{
		"AndrewRadev/splitjoin.vim",
		enabled = false,
	},
	{
		"Wansmer/treesj",
		-- keys = { "<space>m", "gJ", "gS" },
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
		keys = {
			{
				"gS",
				function()
					require("treesj").split()
				end,
				desc = "Split lines",
			},
			{
				"gJ",
				function()
					require("treesj").join()
				end,
				desc = "Join lines",
			},
			{
				"<leader>m",
				function()
					require("treesj").toggle()
				end,
				desc = "Toggle lines",
			},
		},
		config = function()
			require("treesj").setup({ --[[ your config ]]
				use_default_keymaps = false,
				check_syntax_error = false,
			})
		end,
	},
}
