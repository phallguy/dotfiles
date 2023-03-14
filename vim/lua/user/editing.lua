-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set("v", "p", '"_dP') -- don't yank into clipboard when pasting
vim.keymap.set("n", "x", '"_x')  -- when deleting a single character don't clobber clipboard

-- better up/down
-- vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
	require("lspsaga.command").load_command("diagnostic_jump_prev")
end, { desc = "Previous diagnostic" })
vim.keymap.set('n', ']d', function()
	require("lspsaga.command").load_command("diagnostic_jump_next")
end  , { desc = "Next diagnostic" })

-- Quickfix
vim.keymap.set("n", "[q", ":cp<CR>", { desc = "Prev qf" })
vim.keymap.set("n", "]q", ":cn<CR>", { desc = "Next qf" })

-- Buffers
vim.keymap.set("n", "<leader>c", ":bp<CR>:bd#<CR>", { desc = "Close" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Comments
-- vim.keymap.set("n", "<C-/><C-/>", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle comment" })
-- vim.keymap.set("n", "<C-_><C-_>", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle comment" })
--
-- vim.keymap.set("v", "<C-/><C-/>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle comment" })
-- vim.keymap.set("v", "<C-_><C-_>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle comment" })

vim.keymap.set("n", "<leader>o", ":only<CR>:set cmdheight=1<CR>", { desc = "Close all but this" })
vim.keymap.set("n", "<leader>O", [[:only|%bd|e#|bd#<CR>]], { desc = "Hard Close all but this" })

-- -- Keep selection after indenting
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })

vim.keymap.set({ "n", "v" }, "<C-a>", "ggVGG", { desc = "Select all" })

-- Move current line / block with Alt-j/k ala vscode.
-- vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
-- vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv-gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv-gv")

-- Formatting
vim.keymap.set("n", "<leader>G", "mygg=G`y", { desc = "Reindent file" }) -- reindent entire file

vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, { desc = "Format" })

vim.cmd([[
autocmd FileType eruby nnoremap <buffer> <leader>lf :silent !htmlbeautifier -b 2 %<CR>
autocmd FileType svg nnoremap <buffer> <leader>lf :silent !htmlbeautifier -b 2 %<CR>
]])

-- Open file in VS Code
vim.keymap.set("n", "<leader>vs",
  ":silent !code --reuse-window --add '<C-r>=getcwd()<CR>' --goto '%:p':<C-r>=line('.')<CR>:<C-r>=col('.')<CR><CR>",
  { desc = "Open in VSCode", silent = true })

-- Easy Align

-- Start interactive EasyAlign in visual mode (e.g. vipga)
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.keymap.set({ "x", "n" }, "ga", "<Plug>(EasyAlign)")


vim.g["qfenter_keymap"] = {
  vopen = { '<C-v>' },
  topen = { '<C-t>' },
}
