return {
	{
		-- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/v2.x/lua/neo-tree/defaults.lua
		"nvim-neo-tree/neo-tree.nvim",
		config = function()
			vim.g.neo_tree_remove_legacy_commands = 1

			require("neo-tree").setup({
				-- log_level = "debug",
				close_if_last_window = true,
				name = {
					trailing_slash = true,
				},
				-- nesting_rules = {
				-- 	["ts"] = { "test.ts" },
				-- 	["tsx"] = { "test.tsx" },
				-- },
				source_selector = {
					show_scrolled_off_parent_node = true,
				},
				default_component_configs = {
					symbols = {
						unstaged = "~",
					},
					git_status = {
						symbols = {
							unstaged = "~",
						},
					},
				},
				window = {
					-- position = "float",
					mappings = {
						["v"] = "open_vsplit",
					},
					popup_border_style = "rounded",
				},
				filesystem = {
					window = {
						mappings = {
							["<space"] = "noop",
							["-"] = "close_node",
							["[c"] = "prev_git_modified",
							["]c"] = "next_git_modified",
							["[g"] = "noop",
							["]g"] = "noop",
							["a"] = "noop",
							["%"] = {
								"add",
								config = {
									show_path = "relative", -- "none", "relative", "absolute"
								},
							},
							["m"] = {
								"move",
								config = {
									show_path = "relative",
							}
							},
							["A"] = "noop",
							["d"] = "add_directory",
							["D"] = "delete",
						},
					},
					hijack_netrw_behavior = "open_current",
					follow_current_file = true,
					bind_to_cwd = false,
					cwd_target = {
						current = "window",
					},
					filtered_items = {
						hide_dotfiles = false,
						hide_by_name = {
							".git",
						},
					},
				},
			})

			vim.keymap.set("n", "<leader>e", "<CMD>Neotree toggle reveal_force_cwd<CR>", { desc = "Toggle tree" })
			vim.keymap.set("n", "<leader>E", "<CMD>Neotree focus<CR>", { desc = "Focs tree" })
			vim.keymap.set("n", "-", "<CMD>Neotree toggle float reveal_force_cwd<CR>", { desc = "Up tree" })
		end,
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
}
