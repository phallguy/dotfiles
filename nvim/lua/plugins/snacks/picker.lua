local snacks = require("snacks")
local picker = snacks.picker

vim.keymap.set("n", ",", function()
	picker.buffers({
		layout = "vscode",
	})
end, { desc = "Buffers" })
vim.keymap.set("n", "<C-p>", picker.smart, { desc = "Find files" })

vim.keymap.set("n", "<CS-P>", function()
	picker.recent({
		cwd = true,
	})
end, { desc = "Recent files" })

vim.keymap.set("n", "<leader>fb", picker.lines, { desc = "Find in buffer" })
vim.keymap.set("n", "<leader>fg", picker.grep, { desc = "Find in files" })
vim.keymap.set("n", "<leader>fG", picker.grep_word, { desc = "Find word in files" })

vim.keymap.set("n", "<leader>fr", function()
	require("grug-far").with_visual_selection({
		transient = true,
		prefills = {
			paths = vim.fn.expand("%:h"),
		},
	})
end, { desc = "Search and replace" })

vim.keymap.set("n", "<leader>fk", picker.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fc", picker.commands, { desc = "Commands" })
vim.keymap.set("n", "<leader>fU", picker.undo, { desc = "Undo history" })
vim.keymap.set("n", "<leader>fH", picker.help, { desc = "[F]ind [H]elp" })

vim.keymap.set("n", "z=", picker.spelling, { desc = "Spelling" })
