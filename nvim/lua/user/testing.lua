local open_overseer = false

local function invoke_test_cmd(fn)
	vim.cmd.update({ mods = { silent = true } })

	fn()
end

vim.keymap.set("n", "<leader>tf", function()
	invoke_test_cmd(function()
		if open_overseer then
				require("overseer").open({ enter = false })
				require("neotest").run.run(vim.fn.expand("%"))
		else
			require("neotest").run.run(vim.fn.expand("%"))
		end
	end)
end, { desc = "Test File" })

vim.keymap.set("n", "<leader>tD", function()
	invoke_test_cmd(function()
		require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
	end)
end, { desc = "Debug File" })

vim.keymap.set("n", "<leader>tc", function()
	invoke_test_cmd(function()
		if open_overseer then
				require("overseer").open({ enter = false })
				require("neotest").run.run()
		else
			require("neotest").run.run()
		end
	end)
end, { desc = "Test Current" })

vim.keymap.set("n", "<leader>td", function()
	invoke_test_cmd(function()
		require("neotest").run.run({ strategy = "dap" })
	end)
end, { desc = "Debug Current" })

vim.keymap.set("n", "<leader>tl", function()
	invoke_test_cmd(function()
		if open_overseer then
			require("overseer").open({ enter = false })
		end
		require("neotest").run.run_last()
	end)
end, { desc = "Test Last" })

vim.keymap.set("n", "<leader>tL", function()
	invoke_test_cmd(function()
		require("neotest").run.run_last({ strategy = "dap" })
	end)
end, { desc = "Debug Last" })

vim.keymap.set("n", "<leader>tq", function()
	require("neotest").run.stop()
end, { desc = "Test quit" })

vim.keymap.set("n", "<leader>th", function()
	require("neotest").output.open({ last_run = true, auto_close = true, short = true, quiet = true, enter = true })
end, { desc = "Test hint" })

vim.keymap.set("n", "<leader>to", function()
	require("neotest").summary.toggle()
end, { desc = "Test outline" })

vim.keymap.set("n", "<leader>tk", "<CMD>!spring stop<CR>", { desc = "Stop spring" })

vim.keymap.set("n", "]f", function()
	require("neotest").jump.next({ status = "failed" })
end, { desc = "Next failed test" })

vim.keymap.set("n", "[f", function()
	require("neotest").jump.prev({ status = "failed" })
end, { desc = "Previous failed test" })

vim.keymap.set("n", "]t", function()
	require("neotest").jump.next()
end, { desc = "Next test" })

vim.keymap.set("n", "[t", function()
	require("neotest").jump.prev()
end, { desc = "Previous test" })

vim.api.nvim_create_user_command("TestOverseer", function(args)
	open_overseer = true
end, {
	desc = "Show overseer when running tests",
})

vim.api.nvim_create_user_command("StopTestOverseer", function()
	open_overseer = false
end, {
	desc = "Disable automatic overseer on test",
})
