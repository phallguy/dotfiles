return {
	{
		'echasnovski/mini.completion',
		version = '*',
		event = "VeryLazy",
		config = function()
			require("mini.completion").setup({
				delay = {
					commpletion = 500,
					info = 500,
					signature = 150,
				},
			})

			vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
			vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
		end
	},
}
