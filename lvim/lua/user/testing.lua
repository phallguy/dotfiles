lvim.builtin.which_key.mappings[";"] = {
  name = "Testing",
  f = { ":TestFile<CR>", "File" },
  c = { ":TestNearest<CR>", "Current" },
  d = { ":cclose<CR>:TestNearest -strategy=bufferterm<CR>", "Current Terminal" },
  l = { ":TestLast<CR>", "Last" },
}

lvim.builtin.which_key.mappings["r"] = { ":AV<CR>", "Alternate file" }

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