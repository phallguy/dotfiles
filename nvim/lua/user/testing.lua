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
	vim.cmd("TestNearest -strategy=bufferterm")
	vim.opt.scrolloff = old
end, { desc = "Current terminal" })
vim.keymap.set("n", "<leader>tD", function()
	local old = vim.opt.scrolloff
	vim.opt.scrolloff = 0
	vim.cmd({ cmd = "AbortDispatch", mods = { silent = true } })
	vim.cmd("cclose")
	vim.cmd("TestFile -strategy=bufferterm")
	vim.opt.scrolloff = old
end, { desc = "File terminal" })
vim.keymap.set("n", "<leader>tl", "<CMD>TestLast<CR>", { desc = "Last" })

vim.keymap.set("n", "<leader>tL", function()
	local old = vim.opt.scrolloff
	vim.opt.scrolloff = 0
	vim.cmd({ cmd = "AbortDispatch", mods = { silent = true } })
	vim.cmd("cclose")
	vim.cmd("TestLast -strategy=bufferterm")
	vim.opt.scrolloff = old
end, { desc = "Last terminal" })
vim.keymap.set("n", "<leader>tt", "<CMD>TestVisit<CR>", { desc = "Goto last test" })
vim.keymap.set("n", "<leader>tr", "<CMD>Copen<CR>", { desc = "Last test results" })


vim.g["test#preserve_screen"] = 0
vim.g["test#neovim#start_normal"] = 1
vim.g["test#echo_command"] = 0
-- vim.g["test#filename_modifier"] = ":p"

vim.g["test#strategy"] = "dispatch"
-- vim.g["test#strategy"] = "wezterm"
vim.g["test#neovim#term_position"] = "vert botright 30"

vim.cmd([[
augroup TestTerminal
  function! BufferTermStrategy(cmd)
    exec 'te ' . a:cmd
  endfunction

  let g:test#custom_strategies = {'bufferterm': function('BufferTermStrategy')}
augroup END
]])
