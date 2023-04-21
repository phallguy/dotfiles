vim.g.dispatch_no_maps = 1

return {
	{ "janko/vim-test" },
	{ "tpope/vim-dispatch" }, -- Async test runner to quick fix

	-- {
	-- 	"nvim-neotest/neotest",
	-- 	requires = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"antoinemadec/FixCursorHold.nvim",
	-- 		"nvim-neotest/neotest-vim-test",
	-- 		"haydenmeade/neotest-jest",
	-- 	},
	-- 	config = function()
	-- 		require("neotest").setup({
	-- 			adapters = {
	-- 				require("neotest-jest")({
	-- 					jestCommand = "yarn test --",
	-- 					cwd = function()
	-- 						return vim.fn.getcwd()
	-- 					end,
	-- 				}),
	-- 				require("neotest-vim-test"),
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"nvim-neotest/neotest-vim-test",
	-- },
	-- {
	-- 	"haydenmeade/neotest-jest",
	-- },
}
