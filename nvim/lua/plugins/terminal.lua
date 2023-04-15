return {
	-- {
	-- 	"numToStr/FTerm.nvim",
	-- 	opts = {},
	-- 	config = function()
	-- 		require("FTerm").setup({
	-- 			cmd = "bash -il",
	-- 			border = "none",
	-- 			hl = "NormalFloat",
	-- 			dimensions = {
	-- 				height = 0.45,
	-- 				width = 1,
	-- 				x = 0.5,
	-- 				y = 1,
	-- 			}
	-- 		})
	--
	-- 		vim.api.nvim_create_user_command("Te", require("FTerm").toggle, { desc = "Toggle terminal" })
	-- 		vim.keymap.set({ "n", "i", "t" }, "<A-t>", require("FTerm").toggle, { desc = "Toggle terminal" })
	-- 	end,
	-- },
	{
		-- https://github.com/akinsho/toggleterm.nvi
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				-- shading_factor = -15,
				shell = "zsh -il",
				shade_terminals = false,
				highlights = {
					Normal = { guibg = "#1f1d30" },
					NormalFloat = { guibg = "#1f1d30" },
					FloatBorder = { guibg = "#1f1d30", guifg="#44415a"  },
				},
			})
		end,
	},
}