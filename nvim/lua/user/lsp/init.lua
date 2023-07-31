if vim.g.vscode then
	return
end

-- vim.lsp.set_log_level("debug")
require('vim.lsp.log').set_format_func(vim.inspect)

require("user.lsp.mason")
require("user.lsp.diagnostics")
require("user.lsp.lspsaga")
require("user.lsp.mapping")
