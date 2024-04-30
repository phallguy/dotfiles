local capabilities = require("user.lsp.capabilities")

require("lspconfig").marksman.setup({
	capabilities = capabilities,
})
