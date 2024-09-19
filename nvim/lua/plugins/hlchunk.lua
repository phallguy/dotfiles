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
					chars = {
						horizontal_line = "─",
						vertical_line = "│",
						left_top = "╭",
						left_bottom = "╰",
						right_arrow = ">",
					},
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
