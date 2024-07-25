local icons = require("user.icons")
local util = require("user.util")

return {
	{

		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mxsdev/nvim-dap-vscode-js",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"LiadOz/nvim-dap-repl-highlights",
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
			},
			{
				"<leader>dB",
				function()
					require("dap").toggle_breakpoint(vim.fn.input("Condition:"))
				end,
			},
			{
				"<D-\\>",
				function()
					require("dap").continue()
				end,
			},
			{
				"<D-'>",
				function()
					require("dap").step_over()
				end,
			},
			{
				"<D-;>",
				function()
					require("dap").step_into()
				end,
			},
			{
				"<DS-;>",
				function()
					require("dap").run_to_cursor()
				end,
			},
			{
				"<DM-;>",
				function()
					require("dap").step_out()
				end,
			},
			{
				"<leader>dh",
				function()
					require("dap.ui.widgets").hover()
				end,
				mode = { "n", "v" },
				desc = "Widgets",
			},
			{
				"<leader>di",
				function()
					require("dapui").eval(nil, { enter = true })
				end,
				mode = { "n", "v" },
				desc = "Inspect",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Repl",
			},
			{
				"<leader>dd",
				function()
					require("dapui").toggle()
				end,
				desc = "Close DAP",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
					require("dapui").close()
				end,
				desc = "Stop DAP",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
			},
		},
		config = function()
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})

			local dap = require("dap")
			local dapui = require("dapui")

			-- dap.set_log_level("TRACE")
			--

			-- dap.defaults.fallback.focus_terminal = true
			-- dap.defaults.fallback.terminal_win_cmd = "tabnew"
			-- dap.defaults.fallback.stepping_granularity = "instructions"

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "dap-repl" },
				callback = function()
					require("dap.ext.autocompl").attach()
				end,
			})

			for _, language in ipairs({ "typescript", "javascript" }) do
				dap.configurations[language] = {
					-- attach to a node process that has been started with
					-- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
					-- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
					--
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
					},
					{
						-- use nvim-dap-vscode-js's pwa-node debug adapter
						type = "pwa-node",
						-- attach to an already running node process with --inspect flag
						-- default port: 9222
						request = "attach",
						-- allows us to pick the process using a picker
						processId = require("dap.utils").pick_process,
						-- name of the debug action you have to select for this config
						name = "Attach debugger to existing `node --inspect` process",
						-- for compiled languages like TypeScript or Svelte.js
						sourceMaps = true,
						-- resolve source maps in nested locations while ignoring node_modules
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
						-- path to src in vite based projects (and most other projects as well)
						cwd = vim.fn.getcwd(),
						-- we don't want to debug code inside node_modules, so skip it!
						skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
						continueOnAttach = true,
						restart = true,
						autoAttachChildProcesses = true,
					},
					{
						type = "pwa-chrome",
						name = "Launch Chrome to debug client",
						request = "launch",
						url = "http://localhost:5173",
						sourceMaps = true,
						protocol = "inspector",
						port = 9222,
						cwd = vim.fn.getcwd(),
						-- skip files from vite's hmr
						skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
					},
					-- only if language is javascript, offer this debug action
					language == "javascript"
							and {
								-- use nvim-dap-vscode-js's pwa-node debug adapter
								type = "pwa-node",
								-- launch a new process to attach the debugger to
								request = "launch",
								-- name of the debug action you have to select for this config
								name = "Launch file in new node process",
								-- launch current file
								program = "${file}",
								cwd = "${workspaceFolder}",
							}
						or nil,
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
			require("nvim-dap-virtual-text").setup({
				all_references = true, -- show virtual text on all all references of the variable (not only definitions)
				clear_on_continue = true, -- clear virtual text on "continue" (might cause flickering when stepping)
				virt_text_pos = "eol",
			})
			require("nvim-dap-repl-highlights").setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				util.invoke_cmd_with_cursor(function()
					require("neotest").summary.close()
					require("overseer").close()
					dapui.open({ reset = true })
					vim.cmd("wincmd =")
				end)
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				util.invoke_cmd_with_cursor(function()
					dapui.close()
					vim.cmd("wincmd =")
				end)
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				util.invoke_cmd_with_cursor(function()
					dapui.close()
					vim.cmd("wincmd =")
				end)
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
}
