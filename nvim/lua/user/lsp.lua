if vim.g.vscode then
	return
end

-- vim.lsp.set_log_level("debug")

local icons = require("user.icons")

vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "Goto Definition" })
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
vim.keymap.set("n", "<leader>lp", function()
	require("lspsaga.command").load_command("peek_definition")
end, { desc = "Peek [d]efinition" })
vim.keymap.set("n", "<leader>lg", require("telescope.builtin").lsp_definitions, { desc = "[G]o to definition" })
vim.keymap.set("n", "<leader>l/", require("telescope.builtin").lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "<leader>lo", function()
	require("lspsaga.command").load_command("outline")
end, { desc = "Document [o]utline" })

vim.keymap.set("n", "<leader>lu", function()
	require("lspsaga.command").load_command("lsp_finder")
end, { desc = "Usage" })

vim.keymap.set("n", "K", function()
	require("lspsaga.command").load_command("hover_doc")
end, { desc = "Hover Documentation" })
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

vim.keymap.set("n", "<leader>lta", "<CMD>TypescriptAddMissingImports<CR>", { desc = "Add missing imports" })
vim.keymap.set("n", "<leader>ltu", "<CMD>TypescriptRemoveUnused<CR>", { desc = "Remove unused" })
vim.keymap.set("n", "<leader>ltf", "<CMD>TypescriptFixAll<CR>", { desc = "Fix all" })
vim.keymap.set("n", "<leader>lti", "<CMD>TypescriptOrganizeImports<CR>", { desc = "Organize imports" })

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
		if server_name == "solargraph" then
			require("lspconfig").solargraph.setup({
				capabilities = capabilities,
				cmd = { "bundle", "exec", "--gemfile", "Gemfile.local", "solargraph", "stdio" },
			})
		else
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
				settings = servers[server_name],
			})
		end
	end,
})

-- nvim-cmp setup
local cmp = require("cmp")
local compare = require("cmp.config.compare")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

luasnip.config.setup({})

-- command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files()
vim.api.nvim_create_user_command("LuaSnipEdit", function(_)
	require("luasnip.loaders").edit_snippet_files({})
end, { desc = "Edit snippets" })

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	-- completion = {
	-- 	autocomplete = true,
	-- },
	-- performance = {
	-- 	throttle = 1000,
	-- },
	experimental = {
		ghost_text = false,
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<S-CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
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
		{ name = "nvim_lsp" },
		{
			name = "fuzzy_buffer",
			dup = 0,
			option = {
				keyword_length = 2,
				fuzzy_extra_arg = 2, -- Respect case
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "git" },
		{ name = "path" },
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			compare.kind,
			require("cmp_fuzzy_buffer.compare"),
			-- compare.offset,
			compare.recently_used,
			compare.exact,
			compare.score,
			compare.sort_text,
			compare.length,
			compare.order,
		},
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "…", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			menu = {
				fuzzy_buffer = "[Fuzzy Buffer]",
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				git = "[Git]",
				path = "[Path]",
			},
		}),
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
	diagnostic_format = "[#{c}] #{m} (#{s})",
	should_attach = function(bufnr)
		local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")

		return ft ~= "log"
	end,
	sources = {
		-- Diagnostics
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.codespell,
		-- null_ls.builtins.diagnostics.erb_lint,
		null_ls.builtins.diagnostics.rubocop,
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
		show_file = false,
	},
	definition = {
		edit = "<CR>",
	},
	outline = {
		auto_close = true,
		keys = {
			expand_or_jump = "<CR>",
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
		keys = {
			expand_or_jump = "<CR>",
			vsplit = { "<C-v>", "v" },
			split = { "s" },
		},
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
