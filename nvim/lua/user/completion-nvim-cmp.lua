vim.opt.completeopt = { "noselect", "noinsert" }
-- vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local ls = require("luasnip")
local s, sn = ls.snippet, ls.snippet_node
local t, i, d = ls.text_node, ls.insert_node, ls.dynamic_node

local lspkind = require("lspkind")
lspkind.init({})

local cmp = require("cmp")

cmp.setup({
	experimental = {
		ghost_text = true,
	},
	preselect = cmp.PreselectMode.Item,
	window = {
		completion = {
			border = "rounded",
		},
		documentation = {
			border = "rounded",
		},
		signature = {
			border = "rounded",
		},
	},
	matching = {
		-- disallow_partial_fuzzy_matching = true,
		-- disallow_partial_matching = true,
		disallow_prefix_unmatching = true,
		disallow_symbol_nonprefix_matching = true,
	},
	sources = {
		{
			name = "luasnip",
			keyword_length = 2,
			dup = 0,
			max_item_count = 5,
		},
		{ name = "path" },
		{
			name = "nvim_lsp",
			keyword_length = 2,
			max_item_count = 7,
			dup = 0,
		},
		-- { name = "nvim_lsp_signature_help" },
		{
			name = "buffer",
			keyword_length = 2,
			max_indexed_line_length = 2048,
			option = {
				get_bufnrs = function()
					local bufs = {}
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
						local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
						if buftype ~= "nofile" and buftype ~= "prompt" and byte_size < 1024 * 1024 then
							bufs[#bufs + 1] = buf
						end
					end
					return bufs
				end,
			},
		},
	},
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-y>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		-- ["<C-space>"] = cmp.mapping.confirm({
		-- 	behavior = cmp.ConfirmBehavior.Replace,
		-- 	select = true,
		-- }),
		["<tab>"] = cmp.mapping.confirm({
			behavior = cmp.SelectBehavior.Insert,
			select = true,
		}),
		["<C-l>"] = cmp.mapping(function()
			if ls.expand_or_locally_jumpable() then
				ls.expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-h>"] = cmp.mapping(function()
			if ls.locally_jumpable(-1) then
				ls.jump(-1)
			end
		end, { "i", "s" }),

		-- Scroll the documentation window [b]ack / [f]orward
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
	},

	-- Enable luasnip to handle snippet expansion for nvim-cmp
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	formatting = {
		fields = { "kind", "abbr" },
		format = function(entry, vim_item)
			vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
			-- vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
			-- if vim_item.menu then
			-- 	vim_item.menu = string.sub(string.gsub(vim_item.menu, "(^%s*)|(%s*$)", ""), 1, 50)
			-- end
			--
			-- return vim_item
			local highlights_info = require("colorful-menu").cmp_highlights(entry)

			-- if highlight_info==nil, which means missing ts parser, let's fallback to use default `vim_item.abbr`.
			-- What this plugin offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
			if highlights_info ~= nil then
				vim_item.abbr_hl_group = highlights_info.highlights
				vim_item.abbr = highlights_info.text
			end

			return vim_item
		end,
	},

	view = {
		docs = {
			-- auto_open = true,
		},
	},
})

local function uuid()
	local id, _ = vim.fn.system("uuidgen"):gsub("\n", "")
	return id
end

ls.add_snippets("global", {
	s({
		trig = "uuid",
		name = "UUID",
		dscr = "Generate a unique UUID",
	}, {
		d(1, function()
			return sn(nil, i(1, uuid()))
		end),
	}),
})

-- Setup up vim-dadbod
cmp.setup.filetype({ "sql" }, {
	sources = {
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" },
	},
})

ls.config.set_config({
	-- history = false,
	updateevents = "TextChanged,TextChangedI",
})
-- ls.log.set_loglevel("debug")

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
	paths = vim.api.nvim_get_runtime_file("lua/snippets", false),
	priority = 10000,
})

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
	loadfile(ft_path)()
end

ls.filetype_extend("ruby", { "rails", "minitest" })

-- vim.keymap.set({ "i", "s" }, "<c-k>", function()
-- 	if ls.expand_or_jumpable() then
-- 		ls.expand_or_jump()
-- 	end
-- end, { silent = true })
--
-- vim.keymap.set({ "i", "s" }, "<c-j>", function()
-- 	if ls.jumpable(-1) then
-- 		ls.jump(-1)
-- 	end
-- end, { silent = true })

vim.keymap.set("n", "<leader>fs", function()
	require("luasnip.loaders").edit_snippet_files()
end, { desc = "Edit snippets" })
