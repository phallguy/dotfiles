if vim.g.vscode then
  return
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { buffer = bufnr })

    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = bufnr })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    -- vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help", buffer = bufnr })

    vim.keymap.set("n", "<leader>ll", vim.diagnostic.open_float, { desc = "[L]ine diagnostics", buffer = bufnr })
    vim.keymap.set("n", "<leader>l/", require("telescope.builtin").lsp_document_symbols,
      { desc = "Document symbols", buffer = bufnr })

    vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr })
  end,
})
