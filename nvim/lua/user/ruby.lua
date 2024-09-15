vim.g.ruby_indent_access_modifier_style = "indent"
vim.g.ruby_indent_block_style = "do"
vim.g.ruby_indent_hanging_elements = 0
vim.g.ruby_indent_assignment_style = "hanging"
vim.g.no_ruby_maps = 1

vim.g["test#ruby#use_spring_binstub"] = 0

local group = vim.api.nvim_create_augroup("RubyEx", { clear = true })
local initialized_ruby_syntax = false
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "ruby", "eruby" },
	callback = function()
		if not initialized_ruby_syntax then
			vim.cmd([[TSDisable highlight]])
			vim.cmd([[TSEnable highlight]])

			initialized_ruby_syntax = true
		end
		vim.opt_local.indentkeys =
			"0{,0},0),0],!^F,o,O,e,:,=end,=else,=elsif,=when,=in ,=ensure,=rescue,==begin,==end,=private,=protected,=public"
		-- vim.opt_local.smartindent = true
		-- vim.opt_local.autoindent = true
	end,
})
