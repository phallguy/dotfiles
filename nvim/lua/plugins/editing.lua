if vim.g.vscode then
	return {}
end

vim.g.loaded_matchit = 1

return {
	-- Useful plugin to show you pending keybinds.

	-- "gc" to comment visual regions/lines
	{
		"numToStr/Comment.nvim",
		event = "BufEnter",
		opts = {},
	},

	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		event = "VeryLazy",
		opts = {},
	},

 	-- Multi cursors
	{
		"mg979/vim-visual-multi",
		event = "BufEnter",
	},

	{
		"junegunn/vim-easy-align",
		event = "BufEnter"
	}, -- Multi-line bock alignment

	{
		"tpope/vim-surround",
		event = "BufEnter",
	}, -- change surrounding tags/quotes/parens

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
		event = "BufEnter",
		config = function()
			require('nvim-highlight-colors').setup {
				enable_named_colors = false,
			}
		end
	},

	{
		"sheerun/vim-polyglot",
		cond = not vim.g.vscode,
		lazy = true,
		event = "VeryLazy",
		init = function()
			-- vim.g.polyglot_disabled = { "autoindent", "sensible", "ftdetect" }
		end,
		priority = 10,
	},

	{
		"andymass/vim-matchup",
		event = "BufEnter",
		config = function()
			vim.g.matchup_matchparen_deferred = 1 -- work async
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require('nvim-autopairs')
			local Rule   = require('nvim-autopairs.rule')

			npairs.setup({
				check_ts = true,
			})

			local cmp_status_ok, cmp = pcall(require, "cmp")
			if cmp_status_ok then
				cmp.event:on(
					"confirm_done",
					require("nvim-autopairs.completion.cmp").on_confirm_done { tex = false }
				)
			end

			local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
			npairs.add_rules {
				Rule(' ', ' ')
						:with_pair(function(opts)
							local pair = opts.line:sub(opts.col - 1, opts.col)
							return vim.tbl_contains({
								brackets[1][1] .. brackets[1][2],
								brackets[2][1] .. brackets[2][2],
								brackets[3][1] .. brackets[3][2],
							}, pair)
						end)
			}
			for _, bracket in pairs(brackets) do
				npairs.add_rules {
					Rule(bracket[1] .. ' ', ' ' .. bracket[2])
							:with_pair(function() return false end)
							:with_move(function(opts)
								return opts.prev_char:match('.%' .. bracket[2]) ~= nil
							end)
							:use_key(bracket[2])
				}
			end
		end
	},

	{
		"kazhala/close-buffers.nvim",
		event = "VeryLazy",
		opts = {
			preserve_window_layout = { "this" },
		},
	},

	{
		"tpope/vim-projectionist",
		event = "BufEnter"
	},

	-- {
	-- 	"m4xshen/hardtime.nvim",
	-- 	opts = {}
	-- },
}
