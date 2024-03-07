
-- trim.nvim [auto trim spaces]
-- https://github.com/cappyzawa/trim.nvim
return {
	"cappyzawa/trim.nvim",
	event = "BufWrite",
	opts = {
		-- ft_blocklist = {"typescript"},
		trim_on_write = true,
		trim_trailing = true,
		trim_last_line = false,
		trim_first_line = false,
		highlight = true,
		-- patterns = {[[%s/\(\n\n\)\n\+/\1/]]}, -- Only one consecutive bl
	},
}



