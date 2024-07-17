local capabilities = require("user.lsp.capabilities")

require("lspconfig").rubocop.setup({
	filetypes = { "ruby" },
	on_new_config = function(config, root_dir)
		config.cmd = { 'rubocop', '--lsp' }
	end,
})
