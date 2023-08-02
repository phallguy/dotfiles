local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Extend LSP with autocomplete capabilities
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

return capabilities
