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
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
			})
		end,
	}
})

require("lspconfig").solargraph.setup({
	capabilities = capabilities,
	filetypes = { "ruby", "eruby" },
	init_options = {
		formatting = false
	}
})

require("lspconfig").rubocop.setup({
	capabilities = capabilities,
	filetypes = { "ruby" },
	on_new_config = function(config, root_dir)
		config.cmd = { 'rubocop', '--lsp' }
	end
})

require("lspconfig").prettierd.setup({
	capabilities = capabilities,
})
