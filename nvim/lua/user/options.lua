local opt = vim.opt

opt.compatible = false
opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.cmdheight = 0 -- Hide command line unless needed.
opt.showcmd = false
opt.showcmdloc = "statusline"
-- opt.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion.
opt.copyindent = true -- Copy the previous indentation on autoindenting.
opt.conceallevel = 2 -- Reveal * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcrqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.laststatus = 2
opt.list = false -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = false -- Print line number
opt.relativenumber = false -- Relative line numbers oh my!
opt.pumblend = 0 -- Popup blend
opt.pumheight = 20 -- Maximum number of entries in a popup
opt.winblend = 5 -- Window blend
opt.scrolloff = 1000 -- Lines of context, large number keeps code mostly centered
opt.sidescrolloff = 8 -- Same but for side scrolling.
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.tabstop = 2 -- Number of spaces tabs count for
-- opt.cindent = true
opt.shortmess = {
	-- "filnxtToOF"
	a = true,
	s = true,
	W = true, -- I know I just wrote it
	I = true, -- Start clean
	F = true,
	C = true,
}
opt.showmode = false -- Dont show mode since we have a statusline
opt.signcolumn = "yes:1" -- Always show the signcolumn, otherwise it would shift the text each time
opt.ignorecase = false -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals
opt.infercase = true -- Infer cases in keyword completion.
opt.inccommand = "nosplit" -- preview incremental substitute
opt.smartindent = true -- Insert indents automatically
opt.breakindent = true
opt.autoindent = true
opt.preserveindent = true -- Preserve indent structure as much as possible.
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.splitkeep = "cursor"
opt.textwidth = 100
opt.termguicolors = true -- True color support
opt.timeoutlen = 1000
opt.updatetime = 1500 -- Save swap file and trigger CursorHold
opt.ttyfast = true
opt.undofile = true
opt.undolevels = 250
opt.undodir = { os.getenv("HOME") .. "/.vimundo/" } -- use a directory to store the undo history
opt.writebackup = false -- Disable making a backup before overwriting a file.
opt.wildmode = "lastused,longest:full,full" -- Command-line completion mode
opt.wildoptions = "fuzzy,pum"
-- opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.colorcolumn = { 100 }
opt.linebreak = true -- When we do wrap, try to break at natural line boundaries
opt.hlsearch = false -- why even have this?
opt.incsearch = true
opt.foldmethod = "marker"
opt.foldenable = true
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 0
opt.foldopen:append({ "jump" })
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
-- f0 - don't save marks
opt.shada = "'30,s10,h,f0"
--
-- opt.iskeyword:remove({ "-", "_" })
-- opt.iskeyword:append({ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "S", "T", "U", "V", "W", "X", "Y", "Z" })

-- opt.formatoptions = vim.opt.formatoptions._info.default
opt.formatoptions:append({
	c = true, -- Auto wrap comments
	n = true, -- Recognize numbered lists
	j = true, -- Try to remove comment leaders when joining lines
})
opt.formatoptions:remove({
	"t", -- Don't wrap regular text
	"2", -- Don't use 'second' line of paragraph
}) -- U

-- https://mise.jdx.dev/ide-integration.html
-- Prepend mise shims to PATH
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
