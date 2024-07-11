local nsnr = vim.api.nvim_create_namespace("leader_testing")

local function invoke_test_cmd(fn)
	local cursor = vim.fn.getpos(".")

	local scrolloff = vim.opt.scrolloff
	vim.opt.scrolloff = 0

	local cmd_id

	cmd_id = vim.api.nvim_create_autocmd({ "WinResized" }, {
		callback = function()
			vim.schedule(function()
				vim.opt.scrolloff = scrolloff

				if cmd_id then
					vim.defer_fn(function()
						if cmd_id then
							vim.api.nvim_del_autocmd(cmd_id)
							vim.fn.setpos(".", cursor)

							cmd_id = false
						end
					end, 1000)
				end
			end)
		end,
	})

	vim.cmd({ cmd = "AbortDispatch", mods = { silent = true } })
	vim.cmd("cclose")

	fn()
end

vim.keymap.set("n", "<leader>tf", function()
	invoke_test_cmd(function()
		vim.cmd("TestFile")
	end)
end, { desc = "File" })
vim.keymap.set("n", "<leader>tc", function()
	invoke_test_cmd(function()
		vim.cmd("TestNearest")
	end)
end, { desc = "Current" })
vim.keymap.set("n", "<leader>td", function()
	invoke_test_cmd(function()
		vim.cmd("TestNearest -strategy=dap")
	end)
end, { desc = "Current terminal" })
vim.keymap.set("n", "<leader>tD", function()
	invoke_test_cmd(function()
		vim.cmd("TestFile -strategy=dap")
	end)
end, { desc = "File terminal" })
vim.keymap.set("n", "<leader>tl", function()
	invoke_test_cmd(function()
		vim.cmd("TestLast")
	end)
end, { desc = "Last" })

vim.keymap.set("n", "<leader>tL", function()
	invoke_test_cmd(function()
		vim.cmd("TestLast -strategy=dap")
	end)
end, { desc = "Last debug" })
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

	vim.env.DISABLE_SPRING = 1

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
		-- port = 38698,
		localfs = true,
	})

	vim.env.DISABLE_SPRING = nil

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
