return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	config = function()
		require('lsp_signature').setup({
			bind = true,
			noice = true,
			-- hint_inline = function() return true end,
			handler_opts = {
				border = "rounded",
			}
		})
	end
}
