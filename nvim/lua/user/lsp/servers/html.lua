local capabilities = require("user.lsp.capabilities")

require("lspconfig").html.setup({
	capabilities = capabilities,
	filetypes = { "html" },
	embeddedLanguages = {
		css = true,
		javascript = true,
		ruby = true,
		erb = true,
		eruby = true,
	},
	init_options = {
		provideFormatter = true,
	},
})
