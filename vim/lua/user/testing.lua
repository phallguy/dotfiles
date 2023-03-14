vim.keymap.set("n", "<leader>;f", ":TestFile<CR>", { desc = "File" })
vim.keymap.set("n", "<leader>;c", ":TestNearest<CR>", { desc = "Current" })
vim.keymap.set("n", "<leader>;d", ":cclose<CR>:TestNearest -strategy=bufferterm<CR>", { desc = "Current terminal" })
vim.keymap.set("n", "<leader>;l", ":TestLast<CR>", { desc = "Last" })

vim.keymap.set("n", "<leader>r", ":AV<CR>", { desc = "Alternate file" })

vim.g["test#preserve_screen"] = 0
vim.g["test#neovim#start_normal"] = 1
vim.g["test#echo_command"] = 0
vim.g["test#filename_modifier"] = ":p"

vim.g["test#strategy"] = "dispatch"
vim.g["test#neovim#term_position"] = "botright 30"

vim.cmd([[
augroup TestTerminal
  function! BufferTermStrategy(cmd)
    exec 'te ' . a:cmd
  endfunction

  let g:test#custom_strategies = {'bufferterm': function('BufferTermStrategy')}
augroup END
]])
