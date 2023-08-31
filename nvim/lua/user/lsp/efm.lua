require "lspconfig".efm.setup {
	init_options = { documentFormatting = true },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			scss = {
				require("user.lsp.efm.prettier")
			},
			eruby = {
				require("user.lsp.efm.htmlbeautifier")
			}
		}
	}
}
