vim.g.splitjoin_ruby_curly_braces = 0
vim.g.splitjoin_ruby_hanging_args = 0
vim.g.splitjoin_ruby_trailing_comma = 1
vim.g.splitjoin_normalize_whitespace = 1
vim.g.splitjoin_align = 1
vim.g.splitjoin_ruby_options_as_arguments = 1
vim.g.splitjoin_trailing_comma = 1
vim.g.splitjoin_split_mapping = "gS"
vim.g.splitjoin_join_mapping = "gJ"

return {
	{
		"AndrewRadev/splitjoin.vim",
	},
	{
		"Wansmer/treesj",
		-- keys = { "<space>m", "gJ", "gS" },
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
		config = function()
			require("treesj").setup({ --[[ your config ]]
				use_default_keymaps = false,
				check_syntax_error = false,
				max_join_length = 500,
			})

			local langs = require("treesj.langs")["presets"]

			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = "*",
				callback = function()
					local opts = { buffer = true }
					if langs[vim.bo.filetype] then
						vim.keymap.set("n", "gS", "<Cmd>TSJSplit<CR>", opts)
						vim.keymap.set("n", "gJ", "<Cmd>TSJJoin<CR>", opts)
					else
						vim.keymap.set("n", "gS", "<Cmd>SplitjoinSplit<CR>", opts)
						vim.keymap.set("n", "gJ", "<Cmd>SplitjoinJoin<CR>", opts)
					end
				end,
			})
		end,
	},
}
