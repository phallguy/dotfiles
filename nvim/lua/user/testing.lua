local util = require("user.util")
vim.g.test_results_keep = false

local function invoke_test_cmd(fn)
	vim.cmd.update({ mods = { silent = true } })

	if not vim.g.test_results_keep then
		-- vim.schedule(require("neotest").output_panel.clear)
	end

	fn()
end

vim.keymap.set("n", "<leader>tf", function()
	invoke_test_cmd(function()
		require("neotest").run.run(vim.fn.expand("%"))
	end)
end, { desc = "Test File" })

vim.keymap.set("n", "<leader>tD", function()
	invoke_test_cmd(function()
		require("neotest").summary.close()
		require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
	end)
end, { desc = "Debug File" })

vim.keymap.set("n", "<leader>tc", function()
	invoke_test_cmd(function()
		require("neotest").run.run()
	end)
end, { desc = "Test Current" })

vim.keymap.set("n", "<leader>td", function()
	invoke_test_cmd(function()
		require("neotest").summary.close()
		require("neotest").run.run({ strategy = "dap" })
	end)
end, { desc = "Debug Current" })

vim.keymap.set("n", "<leader>tl", function()
	invoke_test_cmd(function()
		require("neotest").run.run_last()
	end)
end, { desc = "Test Last" })

vim.keymap.set("n", "<leader>tL", function()
	invoke_test_cmd(function()
		require("neotest").summary.close()
		require("neotest").run.run_last({ strategy = "dap" })
	end)
end, { desc = "Debug Last" })

-- vim.keymap.set("n", "<leader>tt", "<CMD>TestVisit<CR>", { desc = "Goto last test" })
-- vim.keymap.set("n", "<leader>tr", function()
-- 	util.invoke_cmd_with_cursor(function()
-- 		require("neotest").output_panel.toggle()
-- 	end)
-- end, { desc = "Last output" })

vim.keymap.set("n", "<leader>tk", function()
	vim.schedule(require("neotest").output_panel.clear)
end, { desc = "Last output" })

vim.keymap.set("n", "<leader>ti", function()
	require("neotest").attach_or_output.open({ enter = true, auto_close = true })
end, { desc = "Test results" })

vim.keymap.set("n", "<leader>tr", function()
	require("neotest").attach_or_output.open({ enter = true, auto_close = true })
end, { desc = "Test results" })

vim.keymap.set("n", "<leader>tq", function()
	require("neotest").run.stop()
end, { desc = "Test quit" })

vim.keymap.set("n", "<leader>to", function()
	require("neotest").summary.toggle()
end, { desc = "Test outline" })

vim.keymap.set("n", "]f", function()
	require("neotest").jump.next({ status = "failed" })
end, { desc = "Test outline" })

vim.keymap.set("n", "[f", function()
	require("neotest").jump.prev({ status = "failed" })
end, { desc = "Test outline" })

vim.keymap.set("n", "]t", function()
	require("neotest").jump.next()
end, { desc = "Test outline" })

vim.keymap.set("n", "[t", function()
	require("neotest").jump.prev()
end, { desc = "Test outline" })

vim.api.nvim_create_user_command("TestResultsKeep", function()
	vim.g.test_results_keep = true
end, {
	desc = "Keep tests results on run",
	bang = true,
})

vim.api.nvim_create_user_command("TestResultsClear", function()
	vim.g.test_results_keep = false
end, {
	desc = "Clear tests results on run",
})
