local capabilities = require("user.lsp.capabilities")

require("lspconfig").rust_analyzer.setup({
	capabilities = capabilities,
})
