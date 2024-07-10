vim.keymap.set("n", "<leader>tf", function()
	local old = vim.opt.scrolloff
	vim.opt.scrolloff = 0
	vim.cmd({ cmd = "AbortDispatch", mods = { silent = true } })
	vim.cmd("TestFile")
	vim.opt.scrolloff = old
end, { desc = "File" })
vim.keymap.set("n", "<leader>tc", function()
	local old = vim.opt.scrolloff
	vim.opt.scrolloff = 0
	vim.cmd({ cmd = "AbortDispatch", mods = { silent = true } })
	vim.cmd("TestNearest")
	vim.opt.scrolloff = old
end, { desc = "Current" })
vim.keymap.set("n", "<leader>td", function()
	local old = vim.opt.scrolloff
	vim.opt.scrolloff = 0
	vim.cmd({ cmd = "AbortDispatch", mods = { silent = true } })
	vim.cmd("cclose")
	vim.cmd("TestNearest -strategy=dap")
	vim.opt.scrolloff = old
end, { desc = "Current terminal" })
vim.keymap.set("n", "<leader>tD", function()
	local old = vim.opt.scrolloff
	vim.opt.scrolloff = 0
	vim.cmd({ cmd = "AbortDispatch", mods = { silent = true } })
	vim.cmd("cclose")
	vim.cmd("TestFile -strategy=dap")
	vim.opt.scrolloff = old
end, { desc = "File terminal" })
vim.keymap.set("n", "<leader>tl", "<CMD>TestLast<CR>", { desc = "Last" })

vim.keymap.set("n", "<leader>tL", function()
	local old = vim.opt.scrolloff
	vim.opt.scrolloff = 0
	vim.cmd({ cmd = "AbortDispatch", mods = { silent = true } })
	vim.cmd("cclose")
	vim.cmd("TestLast -strategy=dap")
	vim.opt.scrolloff = old
end, { desc = "Last terminal" })
vim.keymap.set("n", "<leader>tt", "<CMD>TestVisit<CR>", { desc = "Goto last test" })
vim.keymap.set("n", "<leader>tr", "<CMD>Copen<CR>", { desc = "Last test results" })
vim.keymap.set("n", "<leader>tq", "<CMD>AbortDispatch<CR>", { desc = "Abort last run" })

vim.g["test#preserve_screen"] = 0
vim.g["test#neovim#start_normal"] = 1
vim.g["test#echo_command"] = 1
-- vim.g["test#filename_modifier"] = ":p"

vim.g["test#strategy"] = "dispatch"
-- vim.g["test#strategy"] = "wezterm"
vim.g["test#neovim#term_position"] = "vert botright 30"

vim.g["test#neovim_sticky#kill_previous"] = 1
vim.g["test#ruby#bundle_exec"] = 0
vim.g["test#ruby#use_binstubs"] = 0

function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

function StartTestDap(cmd)
	local dap = require("dap")

	local args = split(cmd, " ")
	local program = table.remove(args, 1)

	-- TODO switch base on file type
	-- type = vim.bo.filetype,
	dap.run({
		name = "Run test",
		command = program,
		args = args,
		cwd = vim.fn.getcwd(),
		request = "attach",
		type = "ruby",
		random_port = true,
		localfs = true,
	})

	-- table.insert(args, 1, "--inspect")
	-- table.insert(args, 1, "--no-file-parallelism")
	-- table.insert(args, 1, "--run")
	-- table.insert(args, 1, program)
	--
	-- vim.notify(table.concat(args, " "))
	--
	-- dap.run({
	-- 	type = "pwa-node",
	-- 	request = "launch",
	-- 	program = progrm,
	-- 	programArgs = args,
	-- 	cwd = "${workspaceFolder}",
	-- 	localfs = true,
	-- })
end

vim.cmd([[
augroup TestTerminal
  function! BufferTermStrategy(cmd)
    exec 'te ' . a:cmd
  endfunction

  function! DapStrategy(cmd)
    call luaeval('StartTestDap(_A)', '' . a:cmd)
  endfunction

  let g:test#custom_strategies = {
    \ 'bufferterm': function('BufferTermStrategy'),
    \ 'dap': function('DapStrategy'),
  \ }
augroup END
]])
