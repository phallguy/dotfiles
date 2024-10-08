if vim.g.vscode then
	return {}
end

return {
	{
		-- https://github.com/akinsho/toggleterm.nvim
		"akinsho/toggleterm.nvim",
		lazy = true,
		config = function()
			local colors = require("rose-pine.palette")

			require("toggleterm").setup({
				-- shading_factor = -15,
				shell = "zsh -il",
				shade_terminals = false,
				persist_size = false,
				-- highlights = {
				-- 	Normal = { guibg = colors.surface },
				-- 	NormalFloat = { guibg = colors.surface },
				-- 	FloatBorder = { guibg = colors.surface, guifg = colors.highlight_med },
				-- },
				highlights = require("rose-pine.plugins.toggleterm"),
			})
		end,
		cmd = {
			"TermOpen",
			"TermToggle",
		},
	},
}
