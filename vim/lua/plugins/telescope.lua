if vim.g.vscode then
	return {}
end

-- https://github.com/nvim-telescope/telescope.nvim
return {
	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			local actions = require("telescope.actions")
			local lga_actions = require("telescope-live-grep-args.actions")
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", ",", builtin.buffers, { desc = "Buffers" })
			vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })

			local oldfiles = function()
				builtin.oldfiles({ only_cwd = true })
			end
			vim.keymap.set("n", "<CS-P>", oldfiles, { desc = "Recent files" })
			vim.keymap.set("n", "<MS-P>", oldfiles, { desc = "Recent files" }) -- sloppy keys

			vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Find in buffer" })

			vim.keymap.set(
				"n",
				"<leader>fg",
				require("telescope").extensions.live_grep_args.live_grep_args,
				{ desc = "Live grep" }
			)
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume search" })
			vim.keymap.set("n", "<leader>fe", builtin.registers, { desc = "Registers" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
			vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Commands" })
			vim.keymap.set("n", "<leader>fm", "<CMD>Telescope media_files<CR>", { desc = "Media files" })
			vim.keymap.set("n", "<leader>fu", "<CMD>Telescope undo<CR>", { desc = "Undo history" })

			local show_notifications = function()
				require("telescope").extensions.notify.notify()
			end

			vim.keymap.set("n", "<leader>fn", show_notifications, { desc = "Notifications" })

			require("telescope").setup({
				defaults = {
					initial_mode = "insert",
					path_display = { "truncate" },
					theme = "ivy",
					mappings = {
						i = {
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["?"] = actions.which_key,
							["<C-r>"] = actions.to_fuzzy_refine,
							["<C-space>"] = function(prompt_bufnr)
								require("telescope.actions.generate").refine(prompt_bufnr, {
									prompt_to_prefix = true,
								})
							end,
						},
						n = {
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["?"] = actions.which_key,
						},
					},
				},
				pickers = {
					buffers = {
						theme = "dropdown",
						previewer = false,
						initial_mode = "insert",
						sort_lastused = true,
					},
					live_grep = {
						theme = "ivy",
						-- sort_lastused = true,
					},
					live_grep_args = {
						theme = "ivy",
						-- sort_lastused = true,
					},
					find_files = {
						theme = "ivy",
						previewer = false,
						-- sort_lastused = true,
					},
					oldfiles = {
						theme = "ivy",
						previewer = false,
						-- sort_lastused = true,
					},
					current_buffer_fuzzy_find = {
						theme = "ivy",
						initial_mode = "insert",
						-- sort_lastused = true,
					},
					lsp_document_symbols = {
						theme = "ivy",
						initial_mode = "insert",
						sort_lastused = true,
					}
				},
				extensions = {
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						layout_strategy = "vertical",
						-- sort_lastused = true,
						-- define mappings, e.g.
						mappings = {
							-- extend mappings
							i = {
								["<C-f>"] = lga_actions.quote_prompt(),
								["<CS-f>"] = lga_actions.quote_prompt({ postfix = " --iglob **/" }),
							},
						},
					},
					media_files = {
						filetypes = { "png", "webp", "jpg", "jpeg", "svg" },
						find_cmd = "rg",
					},
				},
			})

			-- Enable telescope fzf native, if installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "live_grep_args")
			pcall(require("telescope").load_extension, "noice")
			pcall(require("telescope").load_extension, "media_files")
			pcall(require("telescope").load_extension, "undo")
		end,
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},

	{ "nvim-telescope/telescope-live-grep-args.nvim" }, -- refine live grep
	{ "nvim-telescope/telescope-media-files.nvim" },
	{ "debugloop/telescope-undo.nvim" },
}
