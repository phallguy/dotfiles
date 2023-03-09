vim.cmd([[
augroup gitEx
  autocmd!

  au FileType gitcommit set tw
  au FileType gitcommit set spell
  au FileType gitcommit PencilSoft
  au FileType git setlocal foldmethod=syntax
augroup END
]])

lvim.builtin.gitsigns.active = false
lvim.builtin.gitsigns.opts.signcolumn = false

lvim.builtin.which_key.mappings["g"] = {
  s = { "<cmd>Telescope git_status<cr>", "Status" },
  d = {
    "<cmd>Gdiff<cr>",
    "Diff",
  },
  b = { "<CMD>G blame<CR>", "Blame" },
  B = { ":<C-r>=line('.')<CR>GBrowse<CR>", "Browse" },
  t = { "<CMD>silent !git difftool %:p<CR>", "Diff tool", silent = true },
  T = { "<CMD>silent !git difftool<CR>", "Diff tool all", silent = true },
  c = { "<C-w>h<C-w>c", "Close diff" }
}
