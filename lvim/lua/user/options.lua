vim.opt.compatible = false
vim.opt.foldmethod = "manual"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.showtabline = 0

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.undofile = true                             -- tell it to use an undo file
vim.opt.undodir = os.getenv("HOME") .. '/.vimundo/' -- use a directory to store the undo history

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.updatetime = 50
vim.opt.startofline = false -- Keep the cursor on the same column

vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.textwidth = 79
vim.opt.formatoptions:remove("t")
vim.opt.formatoptions:append("2c")
vim.opt.tabstop      = 2
vim.opt.softtabstop  = 2
vim.opt.shiftwidth   = 2
-- vim.opt.preserveindent = true
vim.opt.numberwidth  = 3
vim.opt.timeoutlen   = 300
vim.opt.autoindent   = true
vim.opt.smartindent  = true

vim.opt.endofline    = false -- Don't automatically add newline
vim.opt.fixendofline = false
vim.opt.startofline  = false -- Keep the cursor on the same column


-- local termGroup = vim.api.nvim_create_augroup("TerminalGroup", { clear = true })
-- vim.api.nvim_create_autocmd("TermOpen", {
--   command = "startinsert",
--   group   = termGroup
-- })