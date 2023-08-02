local capabilities = require("user.lsp.capabilities")

-- Setup mason so it can manage external tooling
require("mason").setup({
	log_level = vim.log.levels.DEBUG,
	ui = {
		border = "rounded",
	},
})

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
			})
		end,
	}
})

require("user.lsp.servers.rubocop")
require("user.lsp.servers.solargraph")
require("user.lsp.servers.prettier")
require("user.lsp.servers.tsserver")
