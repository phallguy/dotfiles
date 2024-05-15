return {
	{
		'echasnovski/mini.completion',
		version = '*',
		event = "VeryLazy",
		config = function()
			require("mini.completion").setup({
				delay = {
					commpletion = 5000,
					info = 5000,
					signature = 1500,
				},
			})

			vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
			vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
		end
	},
}
