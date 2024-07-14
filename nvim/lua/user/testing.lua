vim.keymap.set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Test File" })
vim.keymap.set("n", "<leader>tc", function()
	require("neotest").run.run()
end, { desc = "Test Current" })

vim.keymap.set("n", "<leader>tl", function()
	require("neotest").run.run_last()
end, { desc = "ktest Last" })

-- vim.keymap.set("n", "<leader>tt", "<CMD>TestVisit<CR>", { desc = "Goto last test" })
vim.keymap.set("n", "<leader>tr", function()
	require("neotest").output_panel.toggle({ enter = true })
end, { desc = "Last test results" })

vim.keymap.set("n", "<leader>th", function()
	require("neotest").output.open({ short = true, auto_close = true })
end, { desc = "Last test results" })

vim.keymap.set("n", "<leader>tq", function()
	require("neotest").run.stop()
end, { desc = "Test quit" })

vim.keymap.set("n", "<leader>to", function()
	require("neotest").summary.toggle()
end, { desc = "Test outline" })
