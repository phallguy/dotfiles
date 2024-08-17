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

	{
		"isakbm/gitgraph.nvim",
		---@type i.ggconfig
		cmd = {
			"GitGraph",
		},
		config = function()
			require("gitgraph").setup({
				symbols = {
					merge_commit = "",
					commit = "",
				},
				format = {
					timestamp = "%h:%m:%s %d-%m-%y",
					fields = { "hash", "timestamp", "author", "branch_name", "tag" },
				},
				hooks = {
					-- check diff of a commit
					on_select_commit = function(commit)
						vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
					end,
					-- check diff from commit a -> commit b
					on_select_range_commit = function(from, to)
						vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
					end,
				},
			})

			vim.api.nvim_create_user_command("GitGraph", function()
				require("gitgraph").draw({}, { all = true, max_count = 500 })
			end, {})
		end,
	},
}
