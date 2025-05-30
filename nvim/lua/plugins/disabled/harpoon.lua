return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			-- REQUIRED
			harpoon:setup()
			-- REQUIRED

			vim.keymap.set("n", "<C-S-a>", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<C-S-r>", function()
				harpoon:list():remove()
			end)

			vim.keymap.set("n", "<C-1>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<C-2>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<C-3>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<C-4>", function()
				harpoon:list():select(4)
			end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-,>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<C-.>", function()
				harpoon:list():next()
			end)

			vim.keymap.set("n", ",", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)
		end,
	},
}
