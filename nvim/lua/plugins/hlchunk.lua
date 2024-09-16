return {
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				chunk = {
					enable = true,
					duration = 0,
					delay = 0,
					textobject = "ac",
				},
				indent = {
					-- enable = true,
				},
				-- line_num = {
				-- 	enable = true,
				-- },
			})
		end,
	},
}
