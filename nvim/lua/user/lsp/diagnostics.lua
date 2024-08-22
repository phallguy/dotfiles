local icons = require("user.icons")

local diagnostics = {
	underline = true,
	virtual_text = false,
	severity_sort = true,
	update_in_insert = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
			[vim.diagnostic.severity.WARN] = icons.diagnostics.BoldWarning,
			[vim.diagnostic.severity.HINT] = icons.diagnostics.BoldHint,
			[vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
		},
		-- 	numhl = {
		-- 		[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
		-- 		[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
		-- 		[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		-- 		[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
		-- 	},
	},
}

vim.diagnostic.config(diagnostics)
