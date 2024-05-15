return {
	{
		'echasnovski/mini.surround',
		version = '*',
		event = "VeryLazy",
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = 'ws',
					delete = 'ds',
					find = '',
					find_left = '',
					highlight = '',
					replace = 'cs',
					update_n_lines = '',

					-- Add this only if you don't want to use extended mappings
					suffix_last = '',
					suffix_next = '',
				},
				search_method = 'cover_or_next',
			})
		end
	},
}
