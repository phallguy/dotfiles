local M = {}

function M.invoke_cmd_with_cursor(fn)
	local cursor = vim.fn.getpos(".")

	local scrolloff = vim.opt.scrolloff
	vim.opt.scrolloff = 0

	local cmd_id
	local scheduled

	cmd_id = vim.api.nvim_create_autocmd({ "WinResized" }, {
		callback = function()
			vim.schedule(function()
				vim.opt.scrolloff = scrolloff

				if cmd_id and not scheduled then
					scheduled = vim.defer_fn(function()
						if cmd_id then
							vim.api.nvim_del_autocmd(cmd_id)
							cmd_id = false

							local current = vim.fn.getpos(".")
							if current[1] == cursor[1] then
								vim.fn.setpos(".", cursor)
							else
								vim.notify("Cursor moved to " .. current[1] .. " from " .. cursor[1])
							end
						end
					end, 1000)
				end
			end)
		end,
	})

	vim.defer_fn(function()
		if cmd_id then
			vim.api.nvim_del_autocmd(cmd_id)
			cmd_id = false
		end
	end, 3000)

	fn()
end

return M
