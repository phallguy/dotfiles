if vim.g.vscode then
	return {}
end

return {
	-- Git magic
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
	},

	-- Even more git magic
	{
		"tpope/vim-rhubarb",
		event = "VeryLazy",
	},

	{
		-- https://github.com/sindrets/diffview.nvim
		"sindrets/diffview.nvim",
		lazy = true,
		cmd = {
			"DiffviewOpen",
			"DiffviewFileHistory",
			"DiffviewClose",
		},
		opts = {
			enhanced_diff_hl = true,
			DiffviewOpen = { "--imply-local" },
			view = {
				default = {
					winbar_info = true,
					disable_diagnostics = true,
				},
				merge_tool = {
					layout = "diff3_mixed",
				},
			},
			hooks = {
				diff_buf_win_enter = function(bufnr)
					vim.keymap.set("n", "q", "<CMD>DiffviewClose<CR>", { buffer = bufnr })
				end,
				diff_buf_read = function(bufnr)
					-- Change local options in diff buffers
					vim.opt_local.wrap = true
				end,
			},
			keymaps = {
				file_panel = {
					q = "<CMD>DiffviewClose<CR>",
				},
			},
		},
	},
	--
	-- {
	-- 	"isakbm/gitgraph.nvim",
	-- 	---@type I.GGConfig
	-- 	opts = {
	-- 		symbols = {
	-- 			merge_commit = "M",
	-- 			commit = "*",
	-- 		},
	-- 		format = {
	-- 			timestamp = "%H:%M:%S %d-%m-%Y",
	-- 			fields = { "hash", "timestamp", "author", "branch_name", "tag" },
	-- 		},
	-- 		hooks = {
	-- 			-- Check diff of a commit
	-- 			on_select_commit = function(commit)
	-- 				vim.notify("DiffviewOpen " .. commit.hash .. "^!")
	-- 				vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
	-- 			end,
	-- 			-- Check diff from commit a -> commit b
	-- 			on_select_range_commit = function(from, to)
	-- 				vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
	-- 				vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
	-- 			end,
	-- 		},
	-- 	},
	-- 	keys = {
	-- 		{
	-- 			"<leader>gl",
	-- 			function()
	-- 				require("gitgraph").draw({}, { all = true, max_count = 5000 })
	-- 			end,
	-- 			desc = "GitGraph - Draw",
	-- 		},
	-- 	},
	-- },
}
