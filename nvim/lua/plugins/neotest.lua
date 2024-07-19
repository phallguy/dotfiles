local icons = require("user.icons")

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
			"nvim-neotest/neotest-plenary",
		},
		config = function()
			local minitest = require("neotest-minitest")
			local original_build_spec = minitest.build_spec

			function minitest.build_spec(args)
				local original = original_build_spec(args)

				if original == nil then
					return original
				end

				local position = args.tree:data()

				if position.type == "test" or position.type == "namespace" then
					local config = require("neotest-minitest.config")
					local id = string.gmatch(position.id, "%d+")()

					original.command = vim.tbl_flatten({
						config.get_test_cmd(),
						position.path .. ":" .. id,
						"-v",
					})
				end

				original.env = {
					RUBY_DEBUG_PORT = 3999,
					RUBY_DEBUG_OPEN = "false",
					RUBY_DEBUG_HOST = "127.0.0.1",
					DISABLE_SPRING = nil,
					NOPRIDE = 1,
				}

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

					original.env.RUBY_DEBUG_OPEN = true
				end

				-- vim.notify(vim.inspect(original))
				return original
			end

			function minitest.filter_dir(name, rel_path, root)
				return name ~= "app" and name ~= "node_modules" and name ~= "tmp" and name ~= "log"
			end

			local group = vim.api.nvim_create_augroup("NeoTestEx", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = { "neotest-attach", "neotest-output", "neotest-output-panel" },
				callback = function(e)
					vim.opt_local.wrap = true
				end,
			})

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
					require("neotest-plenary"),
				},
				icons = {
					passed = icons.test.passed,
					failed = icons.test.failed,
					unknown = icons.test.unknown,
					running = icons.test.running,
					running_animated = icons.common.spinner,
				},
				quickfix = {
					open = function()
						vim.cmd("Trouble quickfix")
					end,
					enabled = false,
				},
				discovery = {
					filter_dir = function(name, rel_path, root)
						return name ~= "node_modules" and name ~= "tmp" and name ~= "log"
					end,
				},
				status = {
					enabled = true,
					signs = false,
					virtual_text = true,
				},
				summary = {
					follow = true,
					animated = false,
				},
				output = {
					open_on_run = false,
				},
				output_panel = {
					enabled = false,
				},
				floating = {
					max_width = 0.95,
				},
				consumers = {
					overseer = require("neotest.consumers.overseer"),
				},
				running = {
					concurrent = false,
				},
				run = {
					concurrent = false,
				},
			})
		end,
	},
}
