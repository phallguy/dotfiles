local icons = require("user.icons")

vim.keymap.set("n", "gd", function()
	require("lspsaga.definition"):goto_definition(1)
end, { desc = "Definition" })
vim.keymap.set("n", "gu", function()
	require("lspsaga.finder"):lsp_finder(1)
end, { desc = "Usage" })
vim.keymap.set("n", "<leader>lrs", function()
	require("lspsaga.rename"):lsp_rename()
end, { desc = "[R]ename [s]ymbol" })
vim.keymap.set("n", "<leader>lca", function()
	require("lspsaga.codeaction"):code_action()
end, { desc = "[C]ode [a]ction" })
vim.keymap.set("n", "<leader>ll", function()
	require("lspsaga.command").load_command("show_line_diagnostics")
end, { desc = "[L]ine diagnostics" })

vim.keymap.set("n", "K", function()
	require("lspsaga.command").load_command("hover_doc")
end, { desc = "Hover Documentation" })
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

local diagnostics = {
	underline = true,
	virtual_text = false,
	signs = {
		active = true,
		values = {
			{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
			{ name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
			{ name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
			{ name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
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
			workspace = { checkThirdParty = false },
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
		border = "rounded"
	}
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
local luasnip = require("luasnip")

luasnip.config.setup({})

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
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
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
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
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
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
		-- null_ls.builtins.completion.spell,
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
