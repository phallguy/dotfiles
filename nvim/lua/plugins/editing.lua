if vim.g.vscode then
	return {}
end

vim.g.loaded_matchit = 1

return {
	-- Useful plugin to show you pending keybinds.
	{
		"folke/which-key.nvim",
		enabled = false,
		opts = {
			marks = false,
			registers = false,
			presets = {
				operators = false,
				motions = false,
			},
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
	{ "tpope/vim-surround" },     -- change surrounding tags/quotes/parens
	{
		"reedes/vim-pencil",
		config = function()
			vim.g["pencil#wrapModeDefault"] = "soft"
		end,
	},
	{
		"junegunn/goyo.vim",
	},
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
	-- {
	-- 	-- TODO compare with autopairs
	-- 	"m4xshen/autoclose.nvim",
	-- 	config = function()
	-- 		require("autoclose").setup({
	-- 			disable_when_touch = true,
	-- 			pair_spaces = true,
	-- 		})
	-- 	end
	-- },
	{
		"windwp/nvim-autopairs",
		config = function()
			local npairs = require('nvim-autopairs')
			local Rule   = require('nvim-autopairs.rule')

			npairs.setup({
				check_ts = true,
			})

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
		opts = {
			preserve_window_layout = { "this" },
		},
	},

	{ "tpope/vim-projectionist" },
}
