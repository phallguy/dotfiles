return {
	{

		"tpope/vim-projectionist",
		dependencies = {
			"tpope/vim-rails",
		},
		config = function()
			vim.g.projectionist_heuristics = {
				["*"] = {
					["app/*.rb"] = {
						alternate = "test/{}_test.rb",
					},
					["test/*_test.rb"] = {
						alternate = "app/{}.rb",
					},
					["app/views/*.html.erb"] = {
						alternate = "app/controllers/{dirname}_controller.rb",
					},
					["app/components/*.html.erb"] = {
						type = "projectedview",
						alternate = "app/components/{}.rb",
						path = "app/components",
					},
					["app/components/*.rb"] = {
						type = "projectedsource",
						related = "app/components/{}.html.erb",
						path = "app/components",
					},
				},
			}

			vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
				pattern = { "*.yml" },
				callback = function()
					vim.bo.filetype = "yaml"
				end,
			})
		end,
	},
}
