return {
	-- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nsie [']quote
		require("mini.ai").setup({
			n_lines = 500,
			search_method = "cover_or_next"
		})

		-- Ad/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		require("mini.splitjoin").setup({
			mappings = {
				toggle = '',
				split  = 'gS',
				join   = 'gJ',
			}
		})

		require("mini.comment").setup()


		-- {
		-- 	"junegunn/vim-easy-align",
		-- }, -- Multi-line bock alignment
		require("mini.align").setup({

		})

		-- {
		-- 	"kazhala/close-buffers.nvim",
		-- 	event = "VeryLazy",
		-- 	opts = {
		-- 		preserve_window_layout = { "this" },
		-- 	},
		-- },
		require("mini.bufremove").setup({

		})

		require("mini.extra").setup()

	end,
}
