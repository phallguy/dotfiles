return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"zidhuss/neotest-minitest",
			"marilari88/neotest-vitest",
		},
		config = function()
			local minitest = require("neotest-minitest")
			local original_build_spec = minitest.build_spec

			function minitest.build_spec(args)
				local original = original_build_spec(args)

				if original == nil then
					return original
				end

				if args.strategy == "dap" then
					original.strategy = {
						name = "Run test",
						command = original.command[1],
						args = { unpack(original.command, 2) },
						cwd = original.cwd,
						request = "attach",
						type = "ruby",
						port = 3999,
						localfs = true,
					}
					-- vim.env.DISABLE_SPRING = 1
					-- vim.defer_fn(function()
					-- 	vim.env.DISABLE_SPRING = nil
					-- end, 5000)
				end

				original.env = {
					RUBY_DEBUG_PORT = 3999,
					RUBY_DEBUG_OPEN = true,
					RUBY_DEBUG_HOST = "127.0.0.1",
					DISABLE_SPRING = nil,
				}

				-- vim.notify(vim.inspect(original))
				return original
			end

			function minitest.filter_dir(name, rel_path, root)
				return name ~= "app" and name ~= "node_modules" and name ~= "tmp" and name ~= "log"
			end

			require("neotest").setup({
				adapters = {
					require("neotest-vitest")({
						filter_dir = function(name, rel_path, root)
							return name ~= "node_modules"
						end,
					}),
					minitest({
						test_cmd = function()
							return vim.tbl_flatten({
								"bin/rails",
								"test",
							})
						end,
					}),
				},
				icons = {
					passed = "",
					running = "",
					running_animated = {
						"⠋",
						"⠙",
						"⠚",
						"⠞",
						"⠖",
						"⠦",
						"⠴",
						"⠲",
						"⠳",
						"⠓",
					},
				},
				quickfix = {
					enabled = false,
					open = false,
				},
				discovery = {
					-- concurrent = 1,
					filter_dir = function(name, rel_path, root)
						return name ~= "node_modules" and name ~= "tmp" and name ~= "log"
					end,
				},
				summary = {
					follow = true,
				},
				output = {
					open_on_run = false,
				},

				run = {
					concurrent = false,
				},
				running = {
					concurrent = false,
				},
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("phallguy_neotest", { clear = true }),
				pattern = {
					"neotest-output-panel",
				},
				callback = function(event)
					-- Can't unlist, messes with fugutive G! commands
					-- vim.bo[event.buf].buflisted = false
					vim.keymap.set("n", "<leader>c", function()
						require("neotest").output_panel.clear()
					end, { buffer = event.buf, silent = true })
				end,
			})
		end,
	},
}
