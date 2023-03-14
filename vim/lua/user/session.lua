vim.cmd([[
augroup TrailingWhitespace
  autocmd!

  " Remove trailing whitespace on save
  function! s:RemoveTrailingWhitespaces()
  "Save last cursor position
  let l = line(".")
  let c = col(".")

  %s/\s\+$//ge

  call cursor(l,c)
  endfunction

  au BufWritePre * :call <SID>RemoveTrailingWhitespaces()
augroup END
]])

vim.cmd([[
" Session management
augroup sourcesession
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
augroup END
]])

vim.opt.autowriteall = true
vim.cmd([[
augroup autosaveEx
  autocmd!

  au FocusLost,BufLeave * silent! update
augroup END
]])
