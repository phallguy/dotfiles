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
vim.keymap.set("n", "<leader>gh", "<CMD>DiffviewFileHistory %<CR>", { desc = "Diff file history" })
vim.keymap.set("n", "<leader>gw", "<CMD>G show<CR>", { desc = "Git show" })
vim.keymap.set("n", "<leader>gb", "<CMD>G blame<CR>", { desc = "Blame" })
vim.keymap.set("n", "<leader>gB", function()
	local r,c = unpack(vim.api.nvim_win_get_cursor(0))
	print(r, c)
	vim.cmd(r .. ":GBrowse")
end, { desc = "Browse", noremap = true })
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
vim.keymap.set("n", "<leader>go", "<CMD>Telescope git_branches<CR>", { desc = "Branches" })
vim.keymap.set("n", "<leader>gr", ":G br phallguy/", { desc = "Branch" })
vim.keymap.set("n", "<leader>gl", "<CMD>DiffviewFileHistory<CR>", { desc = "Recent log" })
vim.keymap.set("n", "<leader>gc", "<CMD>DiffviewClose<CR><CMD>tab G commit -v<CR>", { desc = "Commit", silent = true })
vim.keymap.set("n", "<leader>ga", "<CMD>DiffviewClose<CR><CMD>tab G cam<CR>", { desc = "Commit ammend", silent = true })
vim.keymap.set("n", "<leader>gt", "<CMD>DiffviewClose<CR><CMD>G todo<CR>", { desc = "Todo", silent = true })

vim.opt.fillchars:append({ diff = "╱" })
vim.opt.diffopt:append("iwhite") -- Ignore whitespace

