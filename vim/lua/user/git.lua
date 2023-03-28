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
vim.keymap.set("n", "<leader>gh", "<CMD>DiffviewFileHistory %<CR>", { desc = "Diff file history" })
vim.keymap.set("n", "<leader>gb", "<CMD>G blame<CR>", { desc = "Blame" })
vim.keymap.set("n", "<leader>gB", "<CMD><C-r>=line('.')<CR>GBrowse<CR>", { desc = "Browse" })
vim.keymap.set(
	"n",
	"<leader>gt",
	"<CMD>silent !git difftool --tool Kaleidoscope %:p<CR>",
	{ desc = "Diff tool", silent = true }
)
vim.keymap.set(
	"n",
	"<leader>gT",
	"<CMD>silent !git difftool --tool Kaleidoscope<CR>",
	{ desc = "Diff tool all", silent = true }
)
vim.keymap.set("n", "<leader>gR", "<CMD>Telescope git_branches<CR>", { desc = "Branches" })
vim.keymap.set("n", "<leader>gr", ":G! br phallguy/", { desc = "Branch" })
vim.keymap.set("n", "<leader>gl", "<CMD>DiffviewFileHistory<CR>", { desc = "Recent log" })
vim.keymap.set("n", "<leader>gp", "<CMD>G! pusho<CR>", { desc = "Push" })
vim.keymap.set("n", "<leader>gc", "<CMD>DiffviewClose<CR><CMD>tab G commit -v<CR>", { desc = "Commit" })
vim.keymap.set("n", "<leader>ga", "<CMD>tab G cam<CR>", { desc = "Commit ammend" })

vim.opt.fillchars:append({ diff = "╱" })
vim.opt.diffopt:append("iwhite") -- Ignore whitespace
