local opt = vim.opt

opt.compatible = false
opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 0 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 2
opt.list = false -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers oh my!
opt.pumblend = 0 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.scrolloff = 10 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess = {
	-- "filnxtToOF"
	a = true,
	s = true,
	W = true, -- I know I just wrote it
	I = true, -- Start clean
	F = true,
}
opt.showmode = true -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = false -- Insert indents automatically
opt.breakindent = false
opt.autoindent = true
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.textwidth = 100
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.undodir = { os.getenv("HOME") .. "/.vimundo/" } -- use a directory to store the undo history
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.linebreak = true -- When we do wrap, try to break at natural line boundaries
opt.hlsearch = false -- why even have this?
opt.incsearch = true
opt.foldmethod = "marker"
opt.foldenable = true
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 0
opt.foldopen:append("jump")
opt.endofline = false -- Don't automatically add newline
opt.fixendofline = false
opt.startofline = false -- Keep the cursor on the same column
opt.history = 20 -- Max 'previous' items in search/command/buffer/etc
opt.title = true

opt.backup = false

-- Shared data options
-- https://neovim.io/doc/user/options.html#'shada'
-- ! - Remember global variables
-- ' - # old files
-- / - # Max search history
-- s - Max size of data
-- h - Something about hlsearch
opt.shada = "!,'30,s10,h"

opt.iskeyword:append({ '-' }) -- Kabab case

opt.formatoptions = vim.opt.formatoptions._info.default
opt.formatoptions:append({
	c = true, -- Auto wrap comments
	n = true, -- Recognize numbered lists
	j = true, -- Try to remove comment leaders when joining lines
})
opt.formatoptions:remove({
	"t", -- Don't wrap regular text
	"2", -- Don't use 'second' line of paragraph
}) -- U

if vim.fn.has("nvim-0.9.0") == 1 then
	opt.splitkeep = "screen"
	opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0