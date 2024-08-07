local capabilities = require("user.lsp.capabilities")

-- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
-- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
capabilities.workspace = {
	didChangeWatchedFiles = {
		dynamicRegistration = true,
	},
}

require("lspconfig").markdown_oxide.setup({
	capabilities = capabilities, -- again, ensure that capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
})
