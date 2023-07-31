local capabilities = vim.lsp.protocol.make_client_capabilities()

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
})

mason_lspconfig.setup_handlers({
	function(server_name)
		if server_name == "solargraph" then
			require("lspconfig").solargraph.setup({
				capabilities = capabilities,
				filetypes = { "ruby", "eruby" },
				cmd = { "bundle", "exec", "--gemfile", "Gemfile.local", "solargraph", "stdio" },
			})
		else
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
			})
		end
	end,
})
