vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local ls = require("luasnip")
local s, sn = ls.snippet, ls.snippet_node
local t, i, d = ls.text_node, ls.insert_node, ls.dynamic_node

local cmp = require("blink.cmp")

cmp.setup({
	-- 'default' for mappings similar to built-in completion
	-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
	-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
	-- see the "default configuration" section below for full documentation on how to define
	-- your own keymap.
	keymap = {
		-- preset = "default",
		["<Tab>"] = {
			function(cmp)
				if cmp.snippet_active() then
					return cmp.accept()
				end

				return cmp.select_and_accept()
			end,
			"select_and_accept",
			"fallback",
		},
		["<C-j>"] = { "select_next" },
		["<C-k>"] = { "select_prev" },
		["<C-l>"] = { "snippet_forward", "fallback" },
		["<C-h>"] = { "snippet_backward", "fallback" },
	},

	appearance = {
		-- Sets the fallback highlight groups to nvim-cmp's highlight groups
		-- Useful for when your theme doesn't support blink.cmp
		-- will be removed in a future release
		use_nvim_cmp_as_default = true,
		-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
	},

	-- default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, via `opts_extend`
	sources = {
		default = { "lsp", "path", "snippets", "all_buffers" },
		providers = {
			all_buffers = {
				name = "Buffers",
				module = "blink.cmp.sources.buffer",
				fallback_for = { "lsp" },
				opts = {
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
	},

	-- experimental auto-brackets support
	completion = {
		accept = { auto_brackets = { enabled = true } },
		ghost_text = {
			enabled = true,
		},

		menu = {
			border = "rounded",
		},
	},

	-- experimental signature help support
	signature = { enabled = true },

	snippets = {
		expand = function(snippet)
			ls.lsp_expand(snippet)
		end,
		active = function(filter)
			if filter and filter.direction then
				return ls.jumpable(filter.direction)
			end
			return ls.in_snippet()
		end,
		jump = function(direction)
			ls.jump(direction)
		end,
	},
})

-- snippets

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

vim.keymap.set("n", "<leader>fs", function()
	require("luasnip.loaders").edit_snippet_files()
end, { desc = "Edit snippets" })
