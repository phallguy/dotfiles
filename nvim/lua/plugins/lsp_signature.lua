return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	config = function()
		require('lsp_signature').setup({
			bind = true,
			noice = true,
			doc_lines = 20,
			max_height = 22,
			max_width = 100,
			handler_opts = {
				border = "rounded",
			}
		})
	end
}
