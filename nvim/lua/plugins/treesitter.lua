if vim.g.vscode then
	return {}
end

return {
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground",
		},
		priority = 1000,
		config = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
			require("nvim-treesitter.configs").setup({
				-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = {
					"lua",
					"vimdoc",
					"vim",
					"markdown",
					"markdown_inline",
				},
				-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
				auto_install = true,
				highlight = {
					enable = true,
					-- disable = { "eruby", "embedded_template" },
					disable = { "log" },
					additional_vim_regex_highlighting = false,
					use_languagetree = false,
				},
				indent = { enable = true, disable = { "python" } },
				incremental_selection = {
					enable = true,
					keymaps = {
						scope_incremental = "<c-s>",
						init_selection = "+",
						node_incremental = "+",
						node_decremental = "_",
					},
				},
				matchup = {
					enabled = true,
				},
				autotag = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					},
					playground = {
						enable = true,
						updatetime = 25,
					},
					query_linter = {
						enable = true,
						use_virtual_text = true,
						lint_events = { "BufWrite", "CursorHold" },
					},
				},
			})
		end,
	},

	{ "windwp/nvim-ts-autotag" },
	-- { "windwp/nvim-autopairs", opts = {} },

	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			enable = true,
			max_lines = 3,
		},
	}, -- Show function/scope in windowbar

	{
		"m-demare/hlargs.nvim",
		opts = {
			extras = {
				named_parameters = true,
			},
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	}, -- Highlight method args separately
}
