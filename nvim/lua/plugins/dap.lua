local icons = require("user.icons")

return {
	{

		"mfussenegger/nvim-dap",
		lazy = false,
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"LiadOz/nvim-dap-repl-highlights",
			"jbyuki/one-small-step-for-vimkind",
			-- build debugger from source
			{
				"microsoft/vscode-js-debug",
				version = "1.x",
				build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
			},
			"suketa/nvim-dap-ruby",
		},
		keys = {
			-- normal mode is default
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug toggle breakpoint",
			},
			{
				"<F9>",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug toggle breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").toggle_breakpoint(vim.fn.input("Condition:"))
				end,
				desc = "Debug toggle breakpoint (condition)",
			},
			{
				"<leader>de",
				function()
					require("dap").set_exception_breakpoints()
				end,
				desc = "Debug set exceptikon breakponts",
			},
			{
				"<leader>dc",
				function()
					require("dap").clear_breakpoints()
				end,
				desc = "Debug clear breakponts",
			},
			{
				"<leader>dv",
				"<CMD>DapVirtualTextToggle<CR>",
				desc = "Debug toggle virtual text",
			},
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Debug continue",
			},
			{
				"<D-\\>",
				function()
					require("dap").continue()
				end,
				desc = "Debug continue",
			},
			{
				"<D-'>",
				function()
					require("dap").step_over()
				end,
				desc = "Debug step over",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "Debug step over",
			},
			{
				"<D-;>",
				function()
					require("dap").step_into()
				end,
				desc = "Debug step into",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "Debug step into",
			},
			{
				"<DMS-;>",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Debug run to cursor",
			},
			{
				"<S-F5>",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Debug run to cursor",
			},
			{
				"<DM-;>",
				function()
					require("dap").step_out()
				end,
				desc = "Debug step out",
			},
			{
				"<leader>dh",
				function()
					require("dap.ui.widgets").hover()
				end,
				mode = { "n", "v" },
				desc = "Debug Hover",
			},
			{
				"<leader>di",
				function()
					require("dapui").eval(nil, { enter = true })
				end,
				mode = { "n", "v" },
				desc = "Debug Inspect",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle({
						height = 12,
					})
				end,
				desc = "Debug Repl",
			},
			{
				"<leader>dd",
				function()
					require("dap").repl.close()
					require("dapui").toggle()
				end,
				desc = "Debug Close DAP",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
					require("dapui").close()
				end,
				desc = "Debug Stop DAP",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Debug run last",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dap.set_log_level("TRACE")
			--

			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	pattern = { "dap-repl" },
			-- 	callback = function()
			-- 		require("dap.ext.autocompl").attach()
			-- 	end,
			-- })

			--- Gets a path to a package in the Mason registry.
			--- Prefer this to `get_package`, since the package might not always be
			--- available yet and trigger errors.
			---@param pkg string
			---@param path? string
			local function get_pkg_path(pkg, path)
				pcall(require, "mason")
				local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
				path = path or ""
				local ret = root .. "/packages/" .. pkg .. "/" .. path
				return ret
			end

			require("dap").adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
						"${port}",
					},
				},
			}

			for _, language in ipairs({ "typescript", "javascript" }) do
				dap.configurations[language] = {
					-- attach to a node process that has been started with
					-- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
					-- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
					--
					--
					language == "javascript"
							and {
								-- use nvim-dap-vscode-js's pwa-node debug adapter
								type = "pwa-node",
								-- launch a new process to attach the debugger to
								request = "launch",
								-- name of the debug action you have to select for this config
								name = "Run file",
								-- launch current file
								program = "${file}",
								cwd = "${workspaceFolder}",
								skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
								sourceMaps = false,
							}
						or nil,
					{
						type = "pwa-node",
						request = "attach",
						name = "Auto Attach",
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
						sourceMaps = true,
						cwd = vim.fn.getcwd(),
						continueOnAttach = true,
						restart = true,
						autoAttachChildProcesses = true,
						skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
					},
					-- {
					-- 	-- use nvim-dap-vscode-js's pwa-node debug adapter
					-- 	type = "pwa-node",
					-- 	-- attach to an already running node process with --inspect flag
					-- 	-- default port: 9222
					-- 	request = "attach",
					-- 	-- allows us to pick the process using a picker
					-- 	processId = require("dap.utils").pick_process,
					-- 	-- name of the debug action you have to select for this config
					-- 	name = "Attach debugger to existing `node --inspect` process",
					-- 	-- for compiled languages like TypeScript or Svelte.js
					-- 	sourceMaps = true,
					-- 	-- resolve source maps in nested locations while ignoring node_modules
					-- 	resolveSourceMapLocations = {
					-- 		"${workspaceFolder}/**",
					-- 		"!**/node_modules/**",
					-- 	},
					-- 	-- path to src in vite based projects (and most other projects as well)
					-- 	cwd = vim.fn.getcwd(),
					-- 	-- we don't want to debug code inside node_modules, so skip it!
					-- 	skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
					-- 	continueOnAttach = true,
					-- 	restart = true,
					-- 	autoAttachChildProcesses = true,
					-- },
					-- {
					-- 	type = "pwa-chrome",
					-- 	name = "Launch Chrome to debug client",
					-- 	request = "launch",
					-- 	url = "http://localhost:5173",
					-- 	sourceMaps = true,
					-- 	protocol = "inspector",
					-- 	port = 9222,
					-- 	cwd = vim.fn.getcwd(),
					-- 	-- skip files from vite's hmr
					-- 	skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
					-- },
					-- only if language is javascript, offer this debug action
				}
			end

			require("dap-ruby").setup({})

			dap.configurations.ruby = {
				{
					name = "Run Rails",
					command = "bundle",
					args = { "exec", "rails", "server" },
					request = "launch",
					type = "ruby",
					options = { source_filetype = "ruby" },
					error_on_failure = true,
					random_port = true,
					localfs = true,
					cwd = vim.fn.getcwd(),
				},
				{
					name = "Run file",
					command = "bundle",
					args = { "exec", "ruby", "-rdebug", "-Itest" },
					current_file = true,
					request = "attach",
					type = "ruby",
					options = { source_filetype = "ruby" },
					error_on_failure = true,
					localfs = true,
					random_port = true,
					cwd = vim.fn.getcwd(),
				},
				{
					name = "Attach",
					request = "attach",
					type = "ruby",
					options = { source_filetype = "ruby" },
					localfs = true,
					cwd = vim.fn.getcwd(),
				},
			}
			dap.configurations.eruby = dap.configurations.ruby
			dap.configurations.lua = {
				{
					type = "nlua",
					request = "attach",
					name = "Attach to running Neovim instance",
				},
			}

			dap.adapters.nlua = function(callback, config)
				callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
			end

			require("dapui").setup({
				expand_lines = false,
				render = {
					max_type_length = 25,
					max_value_lines = 20,
				},
				layouts = {
					{
						elements = {
							{
								id = "watches",
								size = 0.05,
							},
							{
								id = "scopes",
								size = 0.55,
							},
							{
								id = "stacks",
								size = 0.30,
							},
							{
								id = "breakpoints",
								size = 0.00,
							},
						},
						position = "right",
						size = 70,
					},

					{
						elements = {
							{
								id = "repl",
								size = 1,
							},
							-- {
							-- 	id = "console",
							-- 	size = 0.5,
							-- },
						},
						position = "bottom",
						size = 10,
					},
				},
			})

			require("overseer").enable_dap()
			require("nvim-dap-repl-highlights").setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				require("dapui").open()
			end

			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = icons.dap.Breakpoint, texthl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)

			vim.fn.sign_define("DapBreakpointCondition", {
				text = icons.dap.BreakpointCondition,
				texthl = "DapBreakpointCondition",
				numhl = "DapBreakpointCondition",
			})

			vim.fn.sign_define(
				"DapStopped",
				{ text = icons.dap.Stopped, texthl = "DapStopped", numhl = "DapStopped", linehl = "DapStoppedLine" }
			)
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		cmd = { "DapVirtualTextToggle", "DapVirtualTextDisable", "DapVirtualTextEnable" },
		opts = {

			all_references = true, -- show virtual text on all all references of the variable (not only definitions)
			clear_on_continue = true, -- clear virtual text on "continue" (might cause flickering when stepping)
			virt_text_pos = "eol",
		},
	},
}
