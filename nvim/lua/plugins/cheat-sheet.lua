return {
	{
		"RishabhRD/nvim-cheat.sh",
		dependencies = { "RishabhRD/popfix" },
		config = function()
			vim.g.cheat_default_window_layout = 'vertical_split'

			vim.keymap.set("n", "<leader>fh", function()
				local word = vim.fn.expand("<cword>")
				vim.cmd("Cheat " .. vim.bo.filetype .. " " .. word)
			end, { desc = "Cheat sheat" } )

			require("nvim-cheat")
		end
	}
}
