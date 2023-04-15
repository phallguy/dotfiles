return {
	"kevinhwang91/nvim-bqf",
	cond = not vim.g.vscode,
	config = function()
		require("bqf").setup({
			auto_enable = true,
			-- auto_resize_height = true,
			preview = {
				win_height = 15,
				win_vheight = 15,
				delay_syntax = 80,
				show_title = false,
			},
		})
	end,
}
