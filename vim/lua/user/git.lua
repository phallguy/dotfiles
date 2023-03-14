vim.cmd([[
augroup gitEx
  autocmd!

  au FileType gitcommit set tw
  au FileType gitcommit set spell
  au FileType gitcommit PencilSoft
  au FileType git setlocal foldmethod=syntax

  au FileType DiffviewFiles nnoremap <leader>c :DiffviewClose<CR>
augroup END
]])

vim.keymap.set("n", "<leader>gs", ":DiffviewOpen<CR>", { desc = "Status" })
vim.keymap.set("n", "<leader>gS", ":DiffviewOpen head~<CR>", { desc = "Status (head~)" })
vim.keymap.set("n", "<leader>gd", ":DiffviewOpen -- %<CR>", { desc = "Diff buffer" })
vim.keymap.set("n", "<leader>gb", ":G blame<CR>", { desc = "Blame" })
vim.keymap.set("n", "<leader>gB", ":<C-r>=line('.')<CR>GBrowse<CR>", { desc = "Browse" })
vim.keymap.set("n", "<leader>gt", ":silent !git difftool %:p<CR>", { desc = "Diff tool", silent = true })
vim.keymap.set("n", "<leader>gT", ":silent !git difftool<CR>", { desc = "Diff tool all", silent = true })

-- https://github.com/pwntester/octo.nvim
require"octo".setup({})
