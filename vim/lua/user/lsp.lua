local icons = require("user.icons")

vim.keymap.set("n", "gd", function()
	require("lspsaga.definition"):goto_definition(1)
end, { desc = "Definition" })
vim.keymap.set("n", "gu", function()
	require("lspsaga.command").load_command("lsp_finder")
end, { desc = "Usage" })

vim.keymap.set("n", "<leader>lrs", function()
	require("lspsaga.rename"):lsp_rename()
end, { desc = "[R]ename [s]ymbol" })

vim.keymap.set("n", "<leader>lrf", "<CMD>TypescriptRenameFile<CR>", { desc = "[R]ename [f]ile" })
vim.keymap.set("n", "<leader>la", function()
	require("lspsaga.codeaction"):code_action()
end, { desc = "Code [a]ction" })
vim.keymap.set("n", "<leader>ll", function()
	require("lspsaga.command").load_command("show_line_diagnostics")
end, { desc = "[L]ine diagnostics" })
vim.keymap.set("n", "<leader>ld", function()
	require("lspsaga.command").load_command("peek_definition")
end, { desc = "Peek [d]efinition" })
vim.keymap.set("n", "<leader>lg", function()
	require("lspsaga.command").load_command("goto_definition")
end, { desc = "[G]o to definition" })

vim.keymap.set("n", "<leader>lu", function()
	require("lspsaga.command").load_command("lsp_finder")
end, { desc = "Usage" })

vim.keymap.set("n", "K", function()
	require("lspsaga.command").load_command("hover_doc")
end, { desc = "Hover Documentation" })
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

vim.keymap.set("n", "<leader>lb", require("telescope.builtin").diagnostics, { desc = "Resume search" })
vim.keymap.set("n", "<leader>lq", vim.diagnostic.setqflist, { desc = "Buffer quickfix" })

-- t = {
--   name = "Typescript",
--   a = { "<CMD>TypescriptAddMissingImports<CR>", "Add missing imports" },
--   u = { "<CMD>TypescriptRemoveUnused<CR>", "Remove unused" },
--   f = { "<CMD>TypescriptFixAll<CR>", "Fix all" },
--   i = { "<CMD>TypescriptOrganizeImports<CR>", "Organize imports" },
-- }

local diagnostics = {
	underline = true,
	virtual_text = false,
	signs = {
		active = true,
		values = {
			{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
			{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
			{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
			{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
		},
	},
}

vim.diagnostic.config(diagnostics)
for _, sign in ipairs(diagnostics.signs.values) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

local servers = {
	tsserver = {},
	lua_ls = {
		Lua = {
			-- workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup({
	ui = {
		border = "rounded",
	},
})

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			settings = servers[server_name],
		})
	end,
})

-- nvim-cmp setup
local cmp = require("cmp")
local cmp_buffer = require("cmp_buffer")
local luasnip = require("luasnip")

luasnip.config.setup({})

-- command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files()
vim.api.nvim_create_user_command("LuaSnipEdit", function(_)
	require("luasnip.loaders").edit_snippet_files({})
end, { desc = "Edit snippets" })

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		-- ["<CR>"] = cmp.mapping.confirm({
		-- 	behavior = cmp.ConfirmBehavior.Replace,
		-- 	select = true,
		-- }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "luasnip" },
		{
			name = "buffer",
			option = {
				keyword_length = 3,
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "nvim_lsp" },
		{ name = "path" },
	},
	sorting = {
		comparators = {
			function(...)
				return cmp_buffer:compare_locality(...)
			end,
		},
	},
})

local typescript_setup, typescript = pcall(require, "typescript")
if typescript_setup then
	-- configure typescript server with plugin
	typescript.setup({
		server = {
			capabilities = capabilities,
		},
	})
end

local null_ls = require("null-ls")

null_ls.setup({
	debug = true,
	border = "rounded",
	debounce = 1000,
	should_attach = function(bufnr)
		local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")

		return not ft == "log"
	end,
	sources = {
		-- Diagnostics
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.codespell,
		-- null_ls.builtins.diagnostics.erb_lint,
		-- null_ls.builtins.diagnostics.rubocop,
		null_ls.builtins.diagnostics.stylelint,
		null_ls.builtins.diagnostics.yamllint,

		-- Fixes
		null_ls.builtins.code_actions.eslint,
		-- null_ls.builtins.code_actions.gitsigns,

		-- Formatting
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettierd,
		-- null_ls.builtins.formatting.erb_lint,
		null_ls.builtins.formatting.fixjson,
		null_ls.builtins.formatting.rubocop,
		null_ls.builtins.formatting.htmlbeautifier.with({
			extra_args = {
				"-b",
				"2",
				"-t",
				"2",
			},
		}),
	},
})

require("lspsaga").setup({
	request_timeout = 30000,
	symbol_in_winbar = {
		enable = false,
	},
	definition = {
		edit = "<CR>",
	},
	outline = {
		auto_close = true,
		keys = {
			jump = "<CR>",
		},
	},
	lightbulb = {
		enable = true,
		enable_in_insert = false,
		sign = true,
		sign_priority = 40,
		virtual_text = false,
	},
	diagnostic = {
		-- don't show in-flight analysis in upper right
		on_insert = false,
		show_virt_line = false,
		-- border_follow = false,
	},
	finder = {
		request_timeout = 10000,
	},
	-- lightbulb = {
	--   show_virt_line = false
	-- },
	beacon = {
		frequency = 3,
	},
	ui = {
		title = false,
		border = "rounded",
		code_action = icons.diagnostics.Hint,
	},
})
