local capabilities = require("user.lsp.capabilities")

require("lspconfig").solargraph.setup({
	filetypes = { "ruby" },
	init_options = {
		formatting = true,
	},
	-- settings = {
	-- 	solargraph = {
	-- 		diagnostics = false,
	-- 	}
	-- }
})
