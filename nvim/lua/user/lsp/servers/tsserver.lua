local capabilities = require("user.lsp.capabilities")

require("lspconfig").tsserver.setup({
	capabilities = capabilities,
})
