return {
	{
		'echasnovski/mini.splitjoin',
		version = '*',
		event = "VeryLazy",
		config = function()
			require("mini.splitjoin").setup({
				mappings = {
					toggle = '',
					split = 'gS',
					join = 'gJ',
				}
			})
		end
	},
}
