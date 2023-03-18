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
					"python",
					"tsx",
					"typescript",
					"help",
					"vim",
					"ruby",
					"typescript",
					"javascript",
					"markdown",
					"markdown_inline",
				},
				-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
				auto_install = true,
				highlight = {
					enable = true,
					-- disable = { "eruby", "embedded_template" },
				},
				indent = { enable = true, disable = { "python", "ruby" } },
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
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["ar"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					-- swap = {
					--   enable = true,
					--   swap_next = {
					--     ['<leader>a'] = '@parameter.inner',
					--   },
					--   swap_previous = {
					--     ['<leader>A'] = '@parameter.inner',
					--   },
					-- },
					playground = {
						enable = true,
					},
					query_linter = {
						enable = true,
						use_virtual_text = true,
						lint_events = { "BufWrite", "CursorHold" },
					},
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			enable = true,
		},
	}, -- Show function/scope in windowbar

	{
		"m-demare/hlargs.nvim",
		opts = {
			extras = {
				named_parameters = true,
			},
		},
	}, -- Highlight method args separately
}