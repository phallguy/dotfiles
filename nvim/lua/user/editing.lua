vim.keymap.set("n", "<leader>s", "<CMD>silent w<CR>", { desc = "Save", silent = true })
vim.keymap.set("n", "<leader>w", "<CMD>silent w<CR>", { desc = "Save", silent = true })
vim.keymap.set("n", "<leader>S", ":saveas %:h/", { desc = "Save as", silent = true })

-- Better paste
vim.keymap.set("v", "p", '"_dP') -- don't yank into clipboard when pasting
vim.keymap.set("n", "x", '"_x') -- when deleting a single character don't clobber clipboard
-- vim.keymap.set("n", "p", "p=`]") -- reindent on paste

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

vim.keymap.set("n", "<Up>", "<CMD>resize +2<CR>", { desc = "Taller" })
vim.keymap.set("n", "<Down>", "<CMD>resize -2<CR>", { desc = "Shorter" })
vim.keymap.set("n", "<Right>", "<CMD>vertical resize +2<CR>", { desc = "Narrower" })
vim.keymap.set("n", "<Left>", "<CMD>vertical resize -2<CR>", { desc = "Wider" })

vim.keymap.set("i", "<Up>", "<Nop>", { desc = "Disabled up" })
vim.keymap.set("i", "<Down>", "<Nop>", { desc = "Disabled down" })
vim.keymap.set("i", "<S-Up>", "<Nop>", { desc = "Disabled up" })
vim.keymap.set("i", "<S-Down>", "<Nop>", { desc = "Disabled down" })

-- Navigation - keep cursor centered when jumping large block

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "<C-f>", "<C-f>zz", { noremap = true })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

-- Diagnostic keymaps

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

-- Buffers
vim.keymap.set("n", "<leader>c", function()
	require("diffview").close()
	require("mini.bufremove").delete()
end, { desc = "Close", silent = true })
vim.keymap.set("n", "<leader>q", "<CMD>DiffviewClose<CR><CMD>q<CR>", { desc = "Quit", silent = true })

vim.keymap.set(
	"n",
	"<leader>o",
	"<CMD>only<CR><CMD>set cmdheight=1<CR>",
	{ desc = "Close all but this", silent = true }
)
vim.keymap.set("n", "<leader>O", function()
	-- require("close_buffers").delete({ type = "other" })
	local bn = vim.fn.bufnr()
	vim.cmd.only()

	for _, bufn in ipairs(vim.api.nvim_list_bufs()) do
		if bufn ~= bn then
			local buftype = vim.api.nvim_buf_get_option(bufn, "buftype")

			if buftype ~= "prompt" then
				require("mini.bufremove").delete(bufn)
			end
		end
	end
end, { desc = "Hard Close all but this", silent = true })

vim.keymap.set({ "n", "v" }, "<C-a>", "ggVGG", { desc = "Select all" })

-- Open file in VS Code
vim.keymap.set(
	"n",
	"<leader>gv",
	":silent !code --reuse-window --add '<C-r>=getcwd()<CR>' --goto '%:p':<C-r>=line('.')<CR>:<C-r>=col('.')<CR><CR>",
	{ desc = "Open in VSCode", silent = true }
)

-- Open url/file in quick preview
-- vim.keymap.set({ "n", "v" }, "gq", "<CMD>!qlmanage -p '<cfile>:p' 2> /dev/null &<CR>", { silent = true })
-- vim.keymap.set({ "n", "v" }, "gQ", "<CMD>!qlmanage -p '%:p' 2> /dev/null<CR>", { silent = true })

vim.keymap.set({ "n", "v" }, "gq", "<CMD>!open '<cfile>:p' 2> /dev/null &<CR>", { silent = true })
vim.keymap.set({ "n", "v" }, "gQ", "<CMD>!open '%:p' 2> /dev/null &<CR>", { silent = true })

vim.g["qfenter_keymap"] = {
	vopen = { "<C-v>" },
	topen = { "<C-t>" },
}

-- help
-- Open vert
vim.cmd.cnoreabbrev("H", "vert", "bo", "h")

local group = vim.api.nvim_create_augroup("HelpEx", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "help" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.opt_local.number = false
		vim.keymap.set("n", "q", "<CMD>lcl<CR><CMD>helpc<CR>", { buffer = event.buf, silent = true })
	end,
})

-- Alternate files
vim.api.nvim_create_user_command("ProjectionistPreDetect", "call projectionist#activate()", {})

vim.keymap.set("n", "<leader>r", "<CMD>ProjectionistPreDetect<CR><CMD>R<CR>", { desc = "Related file (same window)" })
vim.keymap.set("n", "<leader>R", "<CMD>ProjectionistPreDetect<CR><CMD>RV<CR>", { desc = "Related file (V split)" })
vim.keymap.set("n", "<leader>a", "<CMD>ProjectionistPreDetect<CR><CMD>A<CR>", { desc = "Alternate file (same window)" })
vim.keymap.set("n", "<leader>A", "<CMD>ProjectionistPreDetect<CR><CMD>AV<CR>", { desc = "Alternate file (V split)" })

-- vim.keymap.set("n", "<leader>r", "<CMD>R<CR>", { desc = "Related file (same window)" })
-- vim.keymap.set("n", "<leader>R", "<CMD>RV<CR>", { desc = "Related file (V split)" })
-- vim.keymap.set("n", "<leader>a", "<CMD>A<CR>", { desc = "Alternate file (same window)" })
-- vim.keymap.set("n", "<leader>A", "<CMD>AV<CR>", { desc = "Alternate file (V split)" })

vim.keymap.set(
	"n",
	"<leader>v",
	"<CMD>ProjectionistPreDetect<CR><CMD>Eprojectedview | Eview<CR>",
	{ desc = "Edit view (Same window)", silent = true }
)
vim.keymap.set(
	"n",
	"<leader>V",
	"<CMD>ProjectionistPreDetect<CR><CMD>Vprojectedview | Vview<CR>",
	{ desc = "Edit view (V split)", silent = true }
)
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>j",
-- 	"<CMD>ProjectionistPreDetect<CR><CMD>Eprojectedjavascript<CR>",
-- 	{ desc = "Edit javascript (Same window)", silent = true }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>J",
-- 	"<CMD>ProjectionistPreDetect<CR><CMD>Vprojectedjavascript<CR>",
-- 	{ desc = "Edit javascript (V split)", silent = true }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>p",
-- 	"<CMD>ProjectionistPreDetect<CR><CMD>Eprojectedpreview<CR>",
-- 	{ desc = "Edit preview (Same window)", silent = true }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>P",
-- 	"<CMD>ProjectionistPreDetect<CR><CMD>Vprojectedpreview<CR>",
-- 	{ desc = "Edit preview (V split)", silent = true }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>y",
-- 	"<CMD>ProjectionistPreDetect<CR><CMD>Eprojectedstylesheet<CR>",
-- 	{ desc = "Edit styles (Same window)" }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>Y",
-- 	"<CMD>ProjectionistPreDetect<CR><CMD>Vprojectedstylesheet<CR>",
-- 	{ desc = "Edit styles (V split)", silent = true }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>b",
-- 	"<CMD>ProjectionistPreDetect<CR><CMD>Eprojectedsource<CR>",
-- 	{ desc = "Edit source (Same window)", silent = true }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>B",
-- 	"<CMD>ProjectionistPreDetect<CR><CMD>Vprojectedsource<CR>",
-- 	{ desc = "Edit source (V split)", silent = true }
-- )

-- Disable recording macros
vim.keymap.set("n", "q", "<Nop>")
vim.keymap.set("", "<RightMouse>", "<Nop>")
