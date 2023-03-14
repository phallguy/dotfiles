vim.cmd([[
augroup gitEx
  autocmd!

  au FileType git setlocal foldmethod=syntax

  au FileType DiffviewFiles nnoremap <localleader>c :DiffviewClose<CR>
augroup END
]])

vim.keymap.set("n", "<leader>gs", ":DiffviewOpen<CR>", { desc = "Status" })
vim.keymap.set("n", "<leader>gS", ":DiffviewOpen head~<CR>", { desc = "Status (head~)" })
vim.keymap.set("n", "<leader>gd", ":DiffviewOpen -- %<CR>", { desc = "Diff buffer" })
vim.keymap.set("n", "<leader>gh", ":DiffviewFileHistory %<CR>", { desc = "Diff buffer" })
vim.keymap.set("n", "<leader>gb", ":G blame<CR>", { desc = "Blame" })
vim.keymap.set("n", "<leader>gB", ":<C-r>=line('.')<CR>GBrowse<CR>", { desc = "Browse" })
vim.keymap.set("n", "<leader>gt", ":silent !git difftool %:p<CR>", { desc = "Diff tool", silent = true })
vim.keymap.set("n", "<leader>gT", ":silent !git difftool<CR>", { desc = "Diff tool all", silent = true })

vim.opt.fillchars:append { diff = "╱" }
vim.opt.diffopt:append "iwhite" -- Ignore whitespace

-- https://github.com/pwntester/octo.nvim
require"octo".setup({})
