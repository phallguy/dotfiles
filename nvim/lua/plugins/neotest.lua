local icons = require("user.icons")

local M = {
	custom_consumers = {},
}

function M.custom_consumers.attach_or_output()
	local self = { name = "attach_or_output" }
	local neotest = require("neotest")

	---@type neotest.Client
	local client = nil

	self = setmetatable(self, {
		__call = function(_, client_)
			client = client_
			return self
		end,
	})

	-- neotest.attach_or_run.open()
	function self.open(args)
		args = args or {}
		local pos = neotest.run.get_tree_from_args(args)
		if pos and client:is_running(pos:data().id) then
			neotest.run.attach()
		else
			neotest.output.open()
		end
	end

	return self
end

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
					NOPRIDE = 1,
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
					passed = icons.test.passed,
					failed = icons.test.failed,
					unknown = icons.test.unknown,
					running = icons.test.running,
					running_animated = icons.common.spinner,
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
					attach_or_output = M.custom_consumers.attach_or_output(),
				},
			})
		end,
	},
}
