if vim.g.vscode then
	return
end

vim.lsp.set_log_level("warn")
require('vim.lsp.log').set_format_func(vim.inspect)

require("user.lsp.mason")
require("user.lsp.diagnostics")
-- require("user.lsp.lspsaga")
require("user.lsp.efm")
require("user.lsp.mapping")
