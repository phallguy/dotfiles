local capabilities = require("user.lsp.capabilities")

-- Setup mason so it can manage external tooling
--
-- Install all the things
-- https://github.com/NormalNvim/NormalNvim/wiki/dependencies#mason-packages
require("mason").setup({
	-- log_level = vim.log.levels.DEBUG,
	ui = {
		-- border = "rounded",
	},
})

require("user.lsp.servers.rubocop")
-- require("user.lsp.servers.solargraph")
require("user.lsp.servers.ts_ls")
require("user.lsp.servers.rust")
require("user.lsp.servers.html")
require("user.lsp.servers.ruby-lsp")
-- require("user.lsp.servers.typos")
-- require("user.lsp.servers.markdown")
require("user.lsp.servers.markdown-oxide")

require("mason-tool-installer").setup({})

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	handlers = {
		function(server_name)
			if server_name == "tsserver" then
				server_name = "ts_ls"
			end
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
			})
		end,
	},
})

for _, plugin in ipairs({
	"mason-lspconfig",
	"mason-nvim-dap",
}) do
	pcall(require, plugin)
end
