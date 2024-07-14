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

			---@param args neotest.RunArgs
			---@return nil | neotest.RunSpec | neotest.RunSpec[]
			function minitest.build_spec(args)
				local original = original_build_spec(args)

				if args.strategy == "dap" then
					original.strategy = {
						name = "Run test",
						command = original.command[1],
						args = { unpack(original.command, 2) },
						cwd = original.cwd,
						request = "attach",
						type = "ruby",
						random_port = true,
						localfs = true,
						error_on_failure = true,
					}
				end

				-- vim.notify(vim.inspect(original))
				return original
			end

			minitest.test_cmd = function()
				return vim.tbl_flatten({
					"bin/rails",
					"test",
				})
			end
			require("neotest").setup({
				adapters = {
					require("neotest-vitest")({
						filter_dir = function(name, rel_path, root)
							return name ~= "node_modules"
						end,
					}),
					minitest,
				},
				icons = {
					passed = "",
					running = "",
				},
				quickfix = {
					enabled = true,
					open = true,
				},
				discovery = {
					concurrent = 1,
					filter_dir = function(name, rel_path, root)
						return name ~= "node_modules"
					end,
				},
			})
		end,
	},
}
