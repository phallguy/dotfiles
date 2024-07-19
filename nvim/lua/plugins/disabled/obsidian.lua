return {
	{
		"epwalsh/obsidian.nvim",
		ft = { "markdown" },
		lazy = true,
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
		},
		-- ~/paul.xheo@gmail.com - Google Drive/My Drive/Obsidian Vault 01:12:11 PM
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/paul.xheo@gmail.com - Google Drive/My Drive/Obsidian Vault",
				},
			},

			follow_url_func = function(url)
				vim.fn.jobstart({ "open", url }) -- Mac OS
			end,
		},
	},
}
