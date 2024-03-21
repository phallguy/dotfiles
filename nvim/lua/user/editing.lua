-- Better save
vim.keymap.set("n", "<leader>s", "<CMD>w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>S", ":saveas %:h/", { desc = "Save as" })

-- Better paste
vim.keymap.set("v", "p", '"_dP') -- don't yank into clipboard when pasting
vim.keymap.set("n", "x", '"_x')  -- when deleting a single character don't clobber clipboard
vim.keymap.set("n", "p", "p=`]") -- reindent on paste


-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

vim.keymap.set("n", "<Up>", "<CMD>resize +2<CR>", { desc = "Taller" })
vim.keymap.set("n", "<Down>", "<CMD>resize -2<CR>", { desc = "Shorter" })
vim.keymap.set("n", "<Right>", "<CMD>vertical resize +2<CR>", { desc = "Narrower" })
vim.keymap.set("n", "<Left>", "<CMD>vertical resize -2<CR>", { desc = "Wider" })

-- Navigation - keep cursor centered when jumping large block

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "<C-f>", "<C-f>zz", { noremap = true })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
	require("lspsaga.command").load_command("diagnostic_jump_prev")
end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", function()
	require("lspsaga.command").load_command("diagnostic_jump_next")
end, { desc = "Next diagnostic" })

-- Quickfix / List
vim.keymap.set("n", "[q", "<CMD>cp<CR>", { desc = "Prev qf entry" })
vim.keymap.set("n", "]q", "<CMD>cn<CR>", { desc = "Next qf entry" })
vim.keymap.set("n", "]Q", "<CMD>cnewer<CR>", { desc = "Next qf list" })
vim.keymap.set("n", "[Q", "<CMD>colder<CR>", { desc = "Prev qf list" })

vim.keymap.set("n", "[l", "<cmd>lprevious<cr>", { desc = "prev list" })
vim.keymap.set("n", "]l", "<cmd>lnext<cr>", { desc = "next list" })

vim.keymap.set("n", "]t", function()
	require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "Next trouble" })

vim.keymap.set("n", "[t", function()
	require("trouble").previous({ skip_groups = true, jump = true })
end, { desc = "Next trouble" })

-- Next/prev diff hunk
if not vim.g.vscode then
	local gs = require("gitsigns")
	vim.keymap.set("n", "]c", function()
		if vim.wo.diff then
			return "]c"
		end
		vim.schedule(function()
			gs.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true, desc = "Next diff hunk" })

	vim.keymap.set("n", "[c", function()
		if vim.wo.diff then
			return "[c"
		end
		vim.schedule(function()
			gs.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true, desc = "Prev diff hunk" })
end

-- Buffers
vim.keymap.set("n", "<leader>c", "<CMD>DiffviewClose<CR><CMD>BDelete this<CR>", { desc = "Close", silent = true })
vim.keymap.set("n", "<leader>q", "<CMD>DiffviewClose<CR><CMD>q<CR>", { desc = "Quit", silent = true })

vim.keymap.set(
	"n",
	"<leader>o",
	"<CMD>only<CR><CMD>set cmdheight=1<CR>",
	{ desc = "Close all but this", silent = true }
)
vim.keymap.set("n", "<leader>O", function()
	require("close_buffers").delete({ type = "other" })
end, { desc = "Hard Close all but this", silent = true })

-- -- Keep selection after indenting
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })

vim.keymap.set({ "n", "v" }, "<C-a>", "ggVGG", { desc = "Select all" })

-- Move current line / block with Alt-j/k ala vscode.
-- vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
-- vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("n", "<CA-J>", "<CMD>m .+1<CR>==")
vim.keymap.set("n", "<CA-K>", "<CMD>m .-2<CR>==")
vim.keymap.set("v", "<CA-J>", "<CMD>m '>+1<CR>gv-gv")
vim.keymap.set("v", "<CA-K>", "<CMD>m '<-2<CR>gv-gv")

-- Formatting
vim.keymap.set("n", "<leader>G", "mygg=G`y", { desc = "Reindent file" }) -- reindent entire file

vim.keymap.set("n", "<leader>lf", function()
	vim.lsp.buf.format({ timeout_ms = 10000 })
end, { desc = "Format" })

-- Open file in VS Code
vim.keymap.set(
	"n",
	"<leader>vs",
	":silent !code --reuse-window --add '<C-r>=getcwd()<CR>' --goto '%:p':<C-r>=line('.')<CR>:<C-r>=col('.')<CR><CR>",
	{ desc = "Open in VSCode", silent = true }
)

-- Easy Align

-- Start interactive EasyAlign in visual mode (e.g. vipga)
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.keymap.set({ "x", "n" }, "ga", "<Plug>(EasyAlign)")

vim.g["qfenter_keymap"] = {
	vopen = { "<C-v>" },
	topen = { "<C-t>" },
}

-- Themeing

vim.cmd([[
augroup HighlightSyntax
	autocmd!
	function! SynStack()
		if !exists("*synstack")
			return
		endif
		echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
	endfunc
augroup END
]])

vim.keymap.set("n", "<leader>ht", "<CMD>TSCaptureUnderCursor<CR>", { desc = "TS captures under cursor" })
vim.keymap.set("n", "<leader>hv", "<CMD>call SynStack()<CR>", { desc = "Vim highlights under cursor" })
vim.keymap.set("n", "<leader>hl", "<CMD>Telescope highlights<CR>", { desc = "All highlights" })
vim.keymap.set("n", "<leader>hi", "<CMD>Inspect<CR>", { desc = "Inspect highlights" })

-- help
-- Open vert
vim.cmd.cnoreabbrev("H", "vert", "bo", "h")

local group = vim.api.nvim_create_augroup("HelpEx", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "help" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.opt_local.number = true
		vim.keymap.set("n", "q", "<CMD>lcl<CR><CMD>helpc<CR>", { buffer = event.buf, silent = true })
	end,
})

-- THICC borders
vim.opt.fillchars = {
	horiz     = '━',
	horizup   = '┻',
	horizdown = '┳',
	vert      = '┃',
	vertleft  = '┫',
	vertright = '┣',
	verthoriz = '╋',
	eob       = ' ',
}
