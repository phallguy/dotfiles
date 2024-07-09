local icons = require("user.icons")

return {
	{

		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mxsdev/nvim-dap-vscode-js",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
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
				"<DM-\\>",
				function()
					require("dap").toggle_breakpoint()
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
				desc = "Widgets",
			},
			{
				"<leader>di",
				function()
					require("dapui").eval(nil, { enter = true })
				end,
				desc = "Inspect",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Repl",
			},
		},
		config = function()
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})

			local dap = require("dap")
			local dapui = require("dapui")

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

			-- dap.adapters.ruby = {
			-- 	type = "executable",
			-- 	command = "bundle",
			-- 	args = { "exec", "readapt", "stdio" },
			-- }
			--
			-- dap.configurations.ruby = {
			-- 	{
			-- 		type = "ruby",
			-- 		request = "launch",
			-- 		name = "Rails",
			-- 		program = "bundle",
			-- 		programArgs = { "exec", "rails", "s" },
			-- 		useBundler = true,
			-- 	},
			-- }
			--

			require("dap-ruby").setup({})
			dap.configurations.ruby = {
				{
					name = "Run Rails",
					command = "bundle",
					args = { "exec", "rails", "s" },
					request = "attach",
					type = "ruby",
					options = { source_filetype = "ruby" },
					error_on_failure = true,
					localfs = true,
					port = 38698,
					cwd = vim.fn.getcwd(),
				},
				{
					name = "Attach Rails",
					command = "bundle",
					args = { "exec", "rails", "s" },
					request = "attach",
					type = "ruby",
					options = { source_filetype = "ruby" },
					error_on_failure = true,
					localfs = true,
					port = 38698,
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
			}

			require("dapui").setup({
				floating = {
					border = "rounded",
				},
				layouts = {
					{
						elements = {
							{
								id = "scopes",
								size = 0.80,
							},

							{
								id = "watches",
								size = 0.05,
							},
							{
								id = "stacks",
								size = 0.10,
							},
							{
								id = "breakpoints",
								size = 0.05,
							},
						},
						position = "right",
						size = 60,
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
						size = 7,
					},
				},
			})
			require("nvim-dap-virtual-text").setup({
				all_references = true, -- show virtual text on all all references of the variable (not only definitions)
				clear_on_continue = true, -- clear virtual text on "continue" (might cause flickering when stepping)
				virt_text_pos = "eol",
			})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({ reset = true })
				vim.diagnostic.enable(false)
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
				vim.diagnostic.enable()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
				vim.diagnostic.enable()
			end

			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = icons.dap.Breakpoint, texthl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapStopped",
				{ text = icons.dap.Stopped, texthl = "DapStopped", numhl = "DapStopped", linehl = "DapStoppedLine" }
			)
		end,
	},
	-- https://github.com/mfussenegger/nvim-dap/issues/329
	-- https://github.com/suketa/nvim-dap-ruby/tree/main
	-- https://www.reddit.com/r/ruby/comments/1ctwtrd/debugging_ruby_in_neovim/
	-- https://github.com/machakann/vim-sandwich
}
