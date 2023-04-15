vim.keymap.set("n", "<leader>tf", "<CMD>TestFile<CR>", { desc = "File" })
vim.keymap.set("n", "<leader>tc", "<CMD>TestNearest<CR>", { desc = "Current" })
vim.keymap.set("n", "<leader>td", "<CMD>cclose<CR>:TestNearest -strategy=bufferterm<CR>", { desc = "Current terminal" })
vim.keymap.set("n", "<leader>tl", "<CMD>TestLast<CR>", { desc = "Last" })
vim.keymap.set("n", "<leader>tt", "<CMD>TestVisit<CR>", { desc = "Goto last test" })
vim.keymap.set("n", "<leader>ts", "<CMD>TestSuite<CR>", { desc = "Suite" })

vim.keymap.set("n", "<leader>r", "<CMD>R<CR>", { desc = "Related file (same window)" })
vim.keymap.set("n", "<leader>R", "<CMD>RV<CR>", { desc = "Related file (V split)" })
vim.keymap.set("n", "<leader>a", "<CMD>A<CR>", { desc = "Alternate file (same window)" })
vim.keymap.set("n", "<leader>A", "<CMD>AV<CR>", { desc = "Alternate file (V split)" })

vim.g["test#preserve_screen"] = 0
vim.g["test#neovim#start_normal"] = 1
vim.g["test#echo_command"] = 0
vim.g["test#filename_modifier"] = ":p"

vim.g["test#strategy"] = "dispatch"
vim.g["test#neovim#term_position"] = "vert botright 30"

vim.cmd([[
augroup TestTerminal
  function! BufferTermStrategy(cmd)
    exec 'te ' . a:cmd
  endfunction

  let g:test#custom_strategies = {'bufferterm': function('BufferTermStrategy')}
augroup END
]])
