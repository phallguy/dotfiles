return {
	"windwp/nvim-autopairs",
  event = 'InsertEnter',
	config = function()
		local npairs = require('nvim-autopairs')
		local Rule   = require('nvim-autopairs.rule')

		npairs.setup({
			check_ts = true,
		})

		local cmp_status_ok, cmp = pcall(require, "cmp")
		if cmp_status_ok then
			cmp.event:on(
				"confirm_done",
				require("nvim-autopairs.completion.cmp").on_confirm_done { tex = false }
			)
		end

		local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
		npairs.add_rules {
			Rule(' ', ' ')
					:with_pair(function(opts)
						local pair = opts.line:sub(opts.col - 1, opts.col)
						return vim.tbl_contains({
							brackets[1][1] .. brackets[1][2],
							brackets[2][1] .. brackets[2][2],
							brackets[3][1] .. brackets[3][2],
						}, pair)
					end)
		}
		for _, bracket in pairs(brackets) do
			npairs.add_rules {
				Rule(bracket[1] .. ' ', ' ' .. bracket[2])
						:with_pair(function() return false end)
						:with_move(function(opts)
							return opts.prev_char:match('.%' .. bracket[2]) ~= nil
						end)
						:use_key(bracket[2])
			}
		end
	end
}
