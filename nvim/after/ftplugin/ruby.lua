vim.opt_local.formatoptions:remove({
	"o", -- Don't open comment on "o"
})

vim.opt.formatoptions:append({
	"t", -- Try to wrap text automatically
})
