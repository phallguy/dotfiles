
vim.g.ruby_indent_access_modifier_style = "indent"
vim.g.ruby_indent_block_style = "do"
vim.g.ruby_indent_hanging_elements = 0
vim.g.ruby_indent_assignment_style = "hanging"
vim.g.no_ruby_maps = 1

vim.g.splitjoin_ruby_curly_braces = 0
vim.g.splitjoin_ruby_hanging_args = 0
vim.g.splitjoin_ruby_trailing_comma = 1
vim.g.splitjoin_normalize_whitespace = 1
vim.g.splitjoin_align = 1
vim.g.splitjoin_ruby_options_as_arguments = 1

vim.g["test#ruby#use_spring_binstub"] = 0

vim.keymap.set("v", "<leader>x", ":Extract ", { desc = "Extract to partial" })

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
		vim.opt_local.indentkeys="0{,0},0),0],!^F,o,O,e,:,=end,=else,=elsif,=when,=in ,=ensure,=rescue,==begin,==end,=private,=protected,=public"
		-- vim.opt_local.smartindent = true
		-- vim.opt_local.autoindent = true
	end,
})
