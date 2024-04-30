return {
	{
		'echasnovski/mini.completion',
		version = '*',
		event = "VeryLazy",
		config = function()
			require("mini.completion").setup({
				delay = {
					commpletion = 300,
					info = 300,
					signature = 150,
				},
				window = {
					info = { border = "rounded" },
					signature = { border = "rounded" }
				}
			})

			vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
			vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
		end
	},
}
