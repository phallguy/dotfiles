local M = {}

function M.invoke_cmd_with_cursor(fn)
	local cursor = vim.fn.getpos(".")

	local scrolloff = vim.opt.scrolloff
	vim.opt.scrolloff = 0

	local cmd_id

	cmd_id = vim.api.nvim_create_autocmd({ "WinResized" }, {
		callback = function()
			vim.schedule(function()
				vim.opt.scrolloff = scrolloff

				if cmd_id then
					vim.defer_fn(function()
						if cmd_id then
							vim.api.nvim_del_autocmd(cmd_id)
							vim.fn.setpos(".", cursor)

							cmd_id = false
						end
					end, 1000)
				end
			end)
		end,
	})

	fn()
end

return M
