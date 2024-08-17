local capabilities = require("user.lsp.capabilities")

require("lspconfig").ruby_lsp.setup({
	capabilities = capabilities,
	filetypes = { "ruby" },
})
