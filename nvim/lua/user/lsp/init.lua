if vim.g.vscode then
	return
end

vim.lsp.set_log_level("debug")

require("user.lsp.mason")
require("user.lsp.neodev")
require("user.lsp.diagnostics")
require("user.lsp.lspsaga")
require("user.lsp.mapping")
