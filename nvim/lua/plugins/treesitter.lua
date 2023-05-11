if vim.g.vscode then
	return {}
end

return {
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground",
		},
		config = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
			require("nvim-treesitter.configs").setup({
				-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = {
					"lua",
					"vimdoc",
					"vim",
					"markdown",
					"markdown_inline",
					"regex",
					"query",
				},
				-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
				auto_install = true,
				highlight = {
					enable = true,
					-- disable = { "log", "eruby", "embedded_template" },
					disable = { "log", "gitcommit" },
					additional_vim_regex_highlighting = { "gitcommit" },
					use_languagetree = false,
				},
				indent = { enable = true, disable = { "python", "ruby", "eruby" } },
				incremental_selection = {
					enable = true,
					keymaps = {
						scope_incremental = "<c-s>",
						init_selection = "+",
						node_incremental = "+",
						node_decremental = "_",
					},
				},
				matchup = {
					enabled = true,
				},
				autotag = {
					enable = true,
				},
				endwise = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim

						keymaps = {
							["am"] = "@function.outer",
							["im"] = "@function.inner",
							["as"] = "@scope.outer",
							["is"] = "@scope.inner",
						},
					},
					move = {
						enable = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
							--
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
							--
							["[s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
							--
							["[S"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						},
					},
					playground = {
						enable = true,
						updatetime = 25,
					},
					query_linter = {
						enable = true,
						use_virtual_text = true,
						lint_events = { "BufWrite", "CursorHold" },
					},
				},
			})

			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

			-- Repeat movement with ; and ,
			-- ensure ; goes forward and , goes backward regardless of the last direction
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		end,
	},

	{ "windwp/nvim-ts-autotag" },
	{
		"windwp/nvim-autopairs",
		cond = false,
		opts = {
			check_ts = true,
		},
	},
	{ "RRethy/nvim-treesitter-endwise" },

	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			enable = true,
			max_lines = 3,
		},
	}, -- Show function/scope in windowbar

	{
		"m-demare/hlargs.nvim",
		cond = false,
		opts = {
			extras = {
				named_parameters = true,
			},
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	}, -- Highlight method args separately
}
