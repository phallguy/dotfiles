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

vim.api.nvim_create_autocmd("TermOpen", {
	group = group,
	pattern = { "term://*toggleterm#*" },
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "<esc>", "<CMD>ToggleTerm<CR>", opts)
	end,
})

vim.keymap.set("n", "<leader>ba", [[<CMD>ToggleTermToggleAll<CR>]], { desc = "Toggle all terminals" })

local Terminal = require("toggleterm.terminal").Terminal
local terminals = {}
local terminalCount = 0

local function createTerminal(name, opts)
	local result = terminals[name]
	if result then
		return result
	end

	result = { name = name }

	local build = function()
		local terminal = result.terminal
		if not terminal then
			local cmd = vim.g["terminal_" .. name .. "_command"]
			if not cmd and opts then
				cmd = opts.cmd
			end

			if not cmd then
				return
			end

			local options = {
				close_on_exit = false,
				auto_scroll = false,
				count = terminalCount,
				cmd = cmd,
			}

			if opts and opts.command and opts.command.opts then
				options = vim.tbl_extend("force", options, opts.command.opts)
			end

			terminal = Terminal:new(options)
			result.terminal = terminal
			result.num = terminalCount

			terminalCount = terminalCount + 1
		end

		return terminal
	end

	local toggle = function()
		local terminal = build()
		if terminal then
			terminal:toggle(20)
		end
	end
	result.toggle = toggle

	if opts and opts.command then
		local command_name = opts.command.name or name
		vim.api.nvim_create_user_command(
			"TermToggle" .. command_name,
			toggle,
			{ desc = "Toggle " .. name .. " terminal" }
		)

		if opts.command.binding then
			vim.keymap.set("n", opts.command.binding, toggle, { desc = "Toggle " .. command_name .. " terminal" })
		end
	end

	return result
end

createTerminal("scratch", {
	cmd = vim.o.shell,
	command = {
		name = "Scratch",
		binding = "<leader>bt",
	},
})

createTerminal("server", {
	command = {
		name = "Server",
		binding = "<leader>bs",
		opts = {
			direction = "float"
		}
	},
})

createTerminal("console", {
	command = {
		name = "Console",
		binding = "<leader>bc",
	},
})

createTerminal("jobs", {
	command = {
		name = "Jobs",
		binding = "<leader>bj",
		opts = {
			direction = "float"
		}
	},
})
