if vim.g.vscode then
	return
end

-- vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "Goto Definition" })
vim.keymap.set("n", "gd", function()
	-- require("lspsaga.command").load_command("goto_definition")
	vim.lsp.buf.definition()
end, { desc = "[G]oto [d]efinition" })

vim.keymap.set("n", "<leader>lrs", function()
	require("lspsaga.rename"):lsp_rename()
end, { desc = "[R]ename [s]ymbol" })

vim.keymap.set("n", "<leader>lrf", "<CMD>TypescriptRenameFile<CR>", { desc = "[R]ename [f]ile" })
vim.keymap.set("n", "<leader>la", function()
	require("lspsaga.codeaction"):code_action()
end, { desc = "Code [a]ction" })
vim.keymap.set("n", "<leader>ll", vim.diagnostic.open_float, { desc = "[L]ine diagnostics" })
vim.keymap.set("n", "<leader>lp", function()
	require("lspsaga.command").load_command("peek_definition")
end, { desc = "Peek [d]efinition" })
vim.keymap.set("n", "<leader>lg", require("telescope.builtin").lsp_definitions, { desc = "[G]o to definition" })
vim.keymap.set("n", "<leader>l/", require("telescope.builtin").lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "<leader>lo", function()
	require("lspsaga.command").load_command("outline")
end, { desc = "Document [o]utline" })

vim.keymap.set("n", "<leader>lu", "<CMD>Lspsaga finder<CR>", { desc = "Usage" })

vim.keymap.set("n", "K", "<CMD>Lspsaga hover_doc<CR>", { desc = "Hover Documentation" })
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

vim.keymap.set("n", "<leader>lta", "<CMD>TypescriptAddMissingImports<CR>", { desc = "Add missing imports" })
vim.keymap.set("n", "<leader>ltu", "<CMD>TypescriptRemoveUnused<CR>", { desc = "Remove unused" })
vim.keymap.set("n", "<leader>ltf", "<CMD>TypescriptFixAll<CR>", { desc = "Fix all" })
vim.keymap.set("n", "<leader>lti", "<CMD>TypescriptOrganizeImports<CR>", { desc = "Organize imports" })
