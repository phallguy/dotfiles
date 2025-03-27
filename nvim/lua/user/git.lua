local group = vim.api.nvim_create_augroup("GitEx", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "git", "gitcommit" },
	callback = function()
		vim.opt_local.foldmethod = "syntax"
	end,
})

vim.keymap.set("n", "<leader>gs", "<CMD>DiffviewOpen<CR>", { desc = "Status" })
vim.keymap.set("n", "<leader>gS", "<CMD>DiffviewOpen head~<CR>", { desc = "Status (head~)" })
vim.keymap.set("n", "<leader>gd", "<CMD>DiffviewOpen -- %<CR>", { desc = "Diff buffer" })
vim.keymap.set("n", "<leader>gD", "<CMD>DiffviewOpen head~ -- %<CR>", { desc = "Diff buffer (head~)" })
vim.keymap.set("n", "<leader>gm", "<CMD>DiffviewOpen origin/master<CR>", { desc = "Diff master" })

vim.keymap.set("n", "<leader>gh", "<CMD>DiffviewFileHistory %<CR>", { desc = "Diff file history" })
vim.keymap.set("n", "<leader>gw", "<CMD>G show<CR>", { desc = "Git show" })
vim.keymap.set("n", "<leader>gb", "<CMD>G blame<CR>", { desc = "Blame" })
vim.keymap.set("n", "<leader>gB", function()
	require("snacks").gitbrowse.open()
end, { desc = "Browse", noremap = true })
vim.keymap.set("n", "<leader>gr", ":G br phallguy/", { desc = "Branch" })
vim.keymap.set("n", "<leader>gl", "<CMD>DiffviewFileHistory<CR>", { desc = "Recent log" })
vim.keymap.set("n", "<leader>gc", "<CMD>tab G commit -v<CR>", { desc = "Commit", silent = true })
vim.keymap.set("n", "<leader>ga", "<CMD>tab G cam<CR>", { desc = "Commit amend", silent = true })
vim.keymap.set("n", "<leader>gt", "<CMD>G todo<CR>", { desc = "Todo", silent = true })
vim.keymap.set("n", "<leader>gh", function()
	require("mini.diff").toggle_overlay()
end, { desc = "Preview hunk inline", silent = true })
-- vim.keymap.set("n", "<leader>gH", "<CMD>Gitsigns preview_hunk<CR>", { desc = "Preview hunk", silent = true })

vim.opt.fillchars:append({ diff = "╱" })
vim.opt.diffopt:append("iwhite") -- Ignore whitespace
