return {
	'Wansmer/treesj',
	-- keys = { '<space>m', '<space>j', '<space>s' },
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
	config = function()
		require('treesj').setup({
			max_join_length = 240,
		})

		vim.keymap.set("n", "gS", function() require("treesj").split() end, { desc = "Split lines" })
		vim.keymap.set("n", "gJ", function() require("treesj").join() end, { desc = "Join lines" })
	end,
}
