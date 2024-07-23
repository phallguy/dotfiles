local capabilities = require("user.lsp.capabilities")

require("lspconfig").typos_lsp.setup({
	capabilities = capabilities,
	filetypes = { "ruby", "javascript", "typescript", "eruby" },
})
