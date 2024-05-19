if vim.g.vscode then
  return
end

-- vim.keymap.set("n", "gd", function()
-- 	vim.lsp.buf.definition()
-- end, { desc = "[G]oto [d]efinition" })

-- vim.keymap.set("n", "<leader>lrf", "<CMD>TypescriptRenameFile<CR>", { desc = "[R]ename [f]ile" })
-- vim.keymap.set("n", "<leader>la", function()
-- 	vim.lsp.buf.code_action()
-- end, { desc = "Code [a]ction" })
-- vim.keymap.set("n", "<leader>ll", vim.diagnostic.open_float, { desc = "[L]ine diagnostics" })
-- vim.keymap.set("n", "<leader>lg", require("telescope.builtin").lsp_definitions, { desc = "[G]o to definition" })
-- vim.keymap.set("n", "<leader>l/", require("telescope.builtin").lsp_document_symbols, { desc = "Document symbols" })

-- vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
-- vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
--
-- vim.keymap.set("n", "<leader>lta", "<CMD>TypescriptAddMissingImports<CR>", { desc = "Add missing imports" })
-- vim.keymap.set("n", "<leader>ltu", "<CMD>TypescriptRemoveUnused<CR>", { desc = "Remove unused" })
-- vim.keymap.set("n", "<leader>ltf", "<CMD>TypescriptFixAll<CR>", { desc = "Fix all" })
-- vim.keymap.set("n", "<leader>lti", "<CMD>TypescriptOrganizeImports<CR>", { desc = "Organize imports" })



vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = bufnr })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help", buffer = bufnr })

    vim.keymap.set("n", "<leader>ll", vim.diagnostic.open_float, { desc = "[L]ine diagnostics", buffer = bufnr })
    vim.keymap.set("n", "<leader>l/", require("telescope.builtin").lsp_document_symbols,
      { desc = "Document symbols", buffer = bufnr })

    -- vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr })
  end,
})
