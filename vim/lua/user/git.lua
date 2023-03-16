vim.cmd([[
augroup gitEx
  autocmd!

  au FileType git setlocal foldmethod=syntax

  au FileType DiffviewFiles nnoremap <buffer> <localleader>c :DiffviewClose<CR>
  au FileType DiffviewFiles nnoremap <buffer> q :DiffviewClose<CR>
augroup END
]])

vim.keymap.set("n", "<leader>gs", "<CMD>DiffviewOpen<CR>", { desc = "Status" })
vim.keymap.set("n", "<leader>gS", "<CMD>DiffviewOpen head~<CR>", { desc = "Status (head~)" })
vim.keymap.set("n", "<leader>gd", "<CMD>DiffviewOpen -- %<CR>", { desc = "Diff buffer" })
vim.keymap.set("n", "<leader>gh", "<CMD>DiffviewFileHistory %<CR>", { desc = "Diff buffer" })
vim.keymap.set("n", "<leader>gb", "<CMD>G blame<CR>", { desc = "Blame" })
vim.keymap.set("n", "<leader>gB", "<CMD><C-r>=line('.')<CR>GBrowse<CR>", { desc = "Browse" })
vim.keymap.set("n", "<leader>gt", "<CMD>silent !git difftool %:p<CR>", { desc = "Diff tool", silent = true })
vim.keymap.set("n", "<leader>gT", "<CMD>silent !git difftool<CR>", { desc = "Diff tool all", silent = true })
vim.keymap.set("n", "<leader>gl", "<CMD>Telescope git_branches<CR>", { desc = "Branches" })

vim.opt.fillchars:append({ diff = "╱" })
vim.opt.diffopt:append("iwhite") -- Ignore whitespace

-- https://github.com/pwntester/octo.nvim
require("octo").setup({})
