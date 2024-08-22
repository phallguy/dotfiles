return {
	{
		-- Only show cursor line in the active window
		"tummetott/reticle.nvim",
		event = "VeryLazy", -- optionally lazy load the plugin
		opts = {
			disable_in_insert = false,
			disable_in_diff = false,
			always_highlight_number = true,
		},
	},
}
