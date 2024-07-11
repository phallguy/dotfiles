local icons = require("user.icons")

return {
	-- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("mini.bufremove").setup({})
		require("mini.comment").setup()
		require("mini.diff").setup({
			view = {
				style = "sign",
				signs = {
					add = "┊",
					change = "┊",
					delete = "┄",
				},
				priority = 10,
			},
		})

		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nsie [']quote
		require("mini.ai").setup({
			n_lines = 500,
			search_method = "cover_or_next",
		})

		-- Ad/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]inner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		--
		local ts_input = require("mini.surround").gen_spec.input.treesitter
		require("mini.surround").setup({
			mappings = {
				add = "as", -- Add surrounding in Normal and Visual modes
				delete = "ds", -- Delete surrounding
				find = "mf", -- Find surrounding (to the right)
				find_left = "mF", -- Find surrounding (to the left)
				highlight = "mh", -- Highlight surrounding
				replace = "cs", -- Replace surrounding
				update_n_lines = "mn", -- Update `n_lines`

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},
			custom_textobjects = {
				t = ts_input({
					outer = "@function.outer",
					inner = "@function.inner",
				}),
			},
		})

		local MiniAlign = require("mini.align")
		require("mini.align").setup({
			modifiers = {
				[":"] = function(steps, opts)
					opts.split_pattern = ":"
					table.insert(steps.pre_justify, MiniAlign.gen_step.trim())
					table.insert(steps.pre_justify, MiniAlign.gen_step.pair())
					opts.merge_delimiter = " "
				end,
			},
		})

		require("mini.icons").setup({
			default = {
				file = { glyph = "" },
				-- directory = { glyph = "󰉖" },
			},
		})
		require("mini.icons").mock_nvim_web_devicons()

		require("mini.extra").setup()
	end,
}
