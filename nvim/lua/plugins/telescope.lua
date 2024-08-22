if vim.g.vscode then
	return {}
end

-- https://github.com/nvim-telescope/telescope.nvim
return {
	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "ghassan0/telescope-glyph.nvim" },
		},
		config = function()
			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			local actions = require("telescope.actions")
			local layout_actions = require("telescope.actions.layout")
			local lga_actions = require("telescope-live-grep-args.actions")
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", ",", builtin.buffers, { desc = "Buffers" })
			vim.keymap.set("n", "<C-p>", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
			vim.keymap.set("n", "<C-p>", "<CMD>Telescope find_files<CR>", { desc = "Find files" })

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
			vim.keymap.set(
				"n",
				"<leader>fG",
				require("telescope-live-grep-args.shortcuts").grep_word_under_cursor,
				{ desc = "Live grep" }
			)
			vim.keymap.set("n", "<leader>fb", function()
				return require("telescope.builtin").live_grep({ grep_open_files = true })
			end, { desc = "Live grep buffers" })
			vim.keymap.set("n", "<leader>fr", "<CMD>GrugFar<CR>", { desc = "Search and replace" })
			vim.keymap.set("n", "<leader>fe", builtin.registers, { desc = "Registers" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
			vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Commands" })
			vim.keymap.set("n", "<leader>fm", "<CMD>Telescope media_files<CR>", { desc = "Media files" })
			vim.keymap.set("n", "<leader>fU", "<CMD>Telescope undo<CR>", { desc = "Undo history" })
			vim.keymap.set("n", "<leader>fd", "<CMD>tab DBUI<CR>", { desc = "Databases" })
			vim.keymap.set("n", "<leader>fH", builtin.help_tags, { desc = "[F]ind [H]elp" })
			vim.keymap.set("n", "<leader>fy", "<CMD>Telescope glyph<CR>", { desc = "[F]ind Gl[y]ph" })

			vim.keymap.set("n", "z=", function()
				require("telescope.builtin").spell_suggest({})
			end, { desc = "Spell suggest" })

			local ivy = {
				theme = "ivy",
				sorting_strategy = "descending",
				layout_config = {
					prompt_position = "bottom",
				},
			}

			require("telescope").setup({
				defaults = {
					initial_mode = "insert",
					path_display = { filename_first = { reverse_directories = true } },
					file_sorter = require("telescope.sorters").get_fuzzy_file,
					generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
					set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
					-- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
					winblend = 0,
					mappings = {
						i = {
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-l>"] = layout_actions.cycle_layout_next,
							["?"] = actions.which_key,
							["<C-r>"] = actions.to_fuzzy_refine,
							["<C-space>"] = function(prompt_bufnr)
								require("telescope.actions.generate").refine(prompt_bufnr, {
									prompt_to_prefix = true,
								})
							end,
						},
						n = {
							-- ["<C-n>"] = actions.cycle_history_next,
							-- ["<C-p>"] = actions.cycle_history_prev,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-l>"] = layout_actions.cycle_layout_next,
							["P"] = layout_actions.toggle_preview,
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
						sort_mru = true,
						ignore_current_buffer = true,

						sorting_strategy = "descending",
						layout_config = {
							prompt_position = "bottom",
						},
					},
					live_grep = ivy,
					live_grep_args = ivy,
					find_files = ivy,
					oldfiles = ivy,
					current_buffer_fuzzy_find = {
						theme = "ivy",
						initial_mode = "insert",
						-- previewer = false,
						sorting_strategy = "descending",
						layout_config = {
							prompt_position = "bottom",
						},
					},
					lsp_definitions = ivy,
					lsp_document_symbols = ivy,
					diagnostics = ivy,
					undo = ivy,
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					live_grep_args = {
						-- auto_quoting = true, -- enable/disable auto-quoting
						layout_strategy = "vertical",
						-- sort_lastused = true,
						-- define mappings, e.g.
						mappings = {
							-- extend mappings
							i = {
								["<C-f>"] = lga_actions.quote_prompt(),
								["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob **/" }),
							},
						},
					},
					media_files = {
						filetypes = { "png", "webp", "jpg", "jpeg", "svg" },
						find_cmd = "rg",
					},
					undo = {
						use_delta = false,
						side_by_side = false,
						layout_strategy = "vertical",
						layout_config = {
							preview_height = 0.8,
						},
					},
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
						wrap_results = true,
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "live_grep_args")
			pcall(require("telescope").load_extension, "media_files")
			pcall(require("telescope").load_extension, "undo")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension, "glyph")
			pcall(require("telescope").load_extension, "emoji")
		end,
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		"nvim-telescope/telescope-fzf-native.nvim",
		lazy = true,
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},

	-- refine live grep
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		lazy = true,
	},
	{
		"xiyaowong/telescope-emoji.nvim",
		lazy = true,
	},
}
