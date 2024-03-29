if vim.g.vscode then
	return {}
end

return {
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		event = "VeryLazy",
		config = function()
			require("bqf").setup({
				auto_enable = true,
				auto_resize_height = true,
				preview = {
					win_height = 8,
					win_vheight = 8,
					show_title = false,
					buf_label = false,
				},
			})
		end,
	},
}
