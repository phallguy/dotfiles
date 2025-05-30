local capabilities = require("user.lsp.capabilities")

capabilities.workspace = {
	didChangeWatchedFiles = {
		dynamicRegistration = true,
	},
}
require("lspconfig").sourcekit.setup({
	capabilities = capabilities,
})
