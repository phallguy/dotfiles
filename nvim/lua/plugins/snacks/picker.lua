return {
	config = {
		matcher = {
			freceny = true,
			cwd_bonus = true,
		},

		formatters = {
			file = {
				filename_first = true,
				truncate = 80,
			},
		},
		layout = "mivy",
		layouts = {
			default = {
				layout = {
					width = 0.75,
				},
			},

			mivy = {
				layout = {
					box = "vertical",
					backdrop = false,
					row = -1,
					width = 0,
					height = 0.4,
					border = "top",
					title = " {title} {live} {flags}",
					title_pos = "left",
					{ win = "input", height = 2 },
					{
						box = "horizontal",
						{ win = "list", border = "none" },
						{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
					},
				},
			},

			vscode = {
				layout = {
					row = 0.4,
					height = 0.2,
				},
			},
		},

		win = {
			preview = {
				wo = {
					number = false,
					spell = false,
				},
			},
			input = {
				keys = {
					["<c-r>"] = { "toggle_live", mode = { "i", "n" } },
					["<c-l>"] = { "focus_preview", mode = { "i", "n" } },
					["<UP>"] = { "history_back", mode = { "i" } },
					["<DOWN>"] = { "history_forward", mode = { "i" } },
				},
			},
		},

		debug = {
			-- scores = true,
			-- files = true,
			-- grep = true,
		},
	},

	bindings = function()
		local snacks = require("snacks")
		local picker = snacks.picker

		vim.keymap.set("n", ",", function()
			picker.buffers({
				layout = "vscode",
				current = false,
			})
		end, { desc = "Buffers" })
		vim.keymap.set("n", "<C-p>", picker.smart, { desc = "Find files" })

		vim.keymap.set("n", "<CS-P>", function()
			picker.recent({
				filter = {
					cwd = true,
				},
				matcher = {
					cwd_bonus = true,
				},
			})
		end, { desc = "Recent files" })

		vim.keymap.set("n", "<leader>fb", picker.lines, { desc = "Find in buffer" })
		vim.keymap.set("n", "<leader>fg", function()
			picker.grep({
				layout = "default",
			})
		end, { desc = "Find in files" })
		vim.keymap.set("n", "<leader>fG", function()
			picker.grep_word({
				layout = "default",
			})
		end, { desc = "Find word in files" })

		vim.keymap.set("n", "<leader>fr", function()
			require("grug-far").with_visual_selection({
				transient = true,
				prefills = {
					paths = vim.fn.expand("%:h"),
				},
			})
		end, { desc = "Search and replace" })

		vim.keymap.set("n", "<leader>fk", picker.keymaps, { desc = "Keymaps" })
		vim.keymap.set("n", "<leader>fc", picker.commands, { desc = "Commands" })
		vim.keymap.set("n", "<leader>fU", picker.undo, { desc = "Undo history" })
		vim.keymap.set("n", "<leader>hh", picker.help, { desc = "[F]ind [H]elp" })

		vim.keymap.set("n", "<leader>go", function()
			require("snacks").picker.git_branches({
				layout = "select",
			})
		end, { desc = "Branches" })
		vim.keymap.set("n", "z=", picker.spelling, { desc = "Spelling" })

		-- Theming

		vim.keymap.set("n", "<leader>hl", snacks.picker.highlights, { desc = "All highlights" })
		vim.keymap.set("n", "<leader>hi", "<CMD>Inspect<CR>", { desc = "Inspect highlights" })
	end,
}
