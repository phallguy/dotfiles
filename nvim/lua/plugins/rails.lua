return {
	{
		"tpope/vim-rails",
		dependencies = {
			"tpope/vim-projectionist",
		},
		config = function()
			-- disable autocmd set filetype=eruby.yaml
			vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost" }, {
				pattern = { "*.rb", "*.erb" },
				callback = function()
					vim.cmd([[
            if RailsDetect() 
              call rails#ruby_setup() 
            endif
				  ]])
				end,
			})
			vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
				pattern = { "*.yml" },
				callback = function()
					vim.bo.filetype = "yaml"
				end,
			})
		end,
	},
	-- {
	-- 	"tpope/vim-bundler",
	-- },
}
