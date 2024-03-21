require "lspconfig".efm.setup {
	init_options = { documentFormatting = true },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			scss = {
				require("user.lsp.efm.prettier")
			},
			css = {
				require("user.lsp.efm.prettier")
			},
			js = {
				require("user.lsp.efm.prettierd")
			},
			typescript = {
				require("user.lsp.efm.prettier")
			},
			eruby = {
				require("user.lsp.efm.htmlbeautifier")
			},
			xml = {
				require("user.lsp.efm.xmllint")
			},
			svg = {
				require("user.lsp.efm.xmllint")
			},
		}
	}
}
