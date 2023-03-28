local group = vim.api.nvim_create_augroup("TermEx", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	group = group,
	pattern = { "term://*" },
	callback = function(event)
		local opts = { buffer = event.buf }
		vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
		vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
		vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
		vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
		vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
		vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
		vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)

		vim.opt_local.signcolumn = "no"
	end,
})

local Terminal = require("toggleterm.terminal").Terminal
local scratchTerminal = Terminal:new({
	close_on_exit = false,
	auto_scroll = false,
	count = 1,
})

vim.keymap.set("n", "<leader>bt", function()
	scratchTerminal:toggle(20)
end, { desc = "Scratch terminal" })

vim.keymap.set({ "n", "t" }, "<A-t>", function()
	scratchTerminal:toggle(20)
end, { desc = "Scratch terminal" })

local serverTerminal
vim.keymap.set("n", "<leader>bs", function()
	if not serverTerminal then
		local serverCmd = vim.g.terminal_server_command

		serverTerminal = Terminal:new({
			cmd = serverCmd,
			close_on_exit = true,
			auto_scroll = true,
			count = 10,
		})
	end

	serverTerminal:toggle(20)
end, { desc = "Project server" })

local consoleTerminal
vim.keymap.set("n", "<leader>bc", function()
	if not consoleTerminal then
		local serverCmd = vim.g.terminal_console_command

		consoleTerminal = Terminal:new({
			cmd = serverCmd,
			close_on_exit = true,
			auto_scroll = true,
			count = 10,
		})
	end

	consoleTerminal:toggle(20)
end, { desc = "Project console" })

vim.keymap.set("n", "<leader>ba", [[<CMD>ToggleTermToggleAll<CR>]], { desc = "Toggle all terminals" })
