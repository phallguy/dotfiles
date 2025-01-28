return {
	{
		"sontungexpt/better-diagnostic-virtual-text",
		enabled = false,
		config = function()
			require("user/lsp/diagnostics")

			require("better-diagnostic-virtual-text").setup({
				inline = false,
			})
		end,
	},
}
