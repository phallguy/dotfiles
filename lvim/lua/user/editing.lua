-- lvim.builtin.which_key.operators = nil
lvim.builtin.which_key.mappings["e"] = nil -- disable file exploreer
lvim.builtin.which_key.mappings["h"] = nil -- disable no highlight
lvim.builtin.which_key.mappings["f"] = nil -- disable find files, use Ctl-p instead
lvim.builtin.which_key.mappings["b"] = {} -- disable buffer commands
lvim.builtin.which_key.mappings["s"] = {} -- disable telescope finds
lvim.builtin.which_key.mappings["p"] = {} -- disable plugins mappings
lvim.builtin.which_key.mappings["T"] = {} -- disable Treesitter info

lvim.builtin.which_key.mappings["n"] = { "<CMD>:cn<CR>", "Next error" }
lvim.builtin.which_key.mappings["p"] = { "<CMD>:cp<CR>", "Prev error" }
lvim.builtin.which_key.mappings["c"] = { ":bn<CR>:bd#<CR>", "Close" }
lvim.builtin.which_key.mappings["q"] = { ":q<CR>", "Quit" }

lvim.lsp.buffer_mappings.normal_mode = {}

lvim.builtin.which_key.setup.plugins.presets.windows = true
lvim.builtin.which_key.setup.plugins.presets.nav = true
lvim.builtin.which_key.setup.plugins.presets.z = true
lvim.builtin.which_key.setup.plugins.presets.g = true
lvim.builtin.which_key.setup.plugins.presets.text_objects = true
lvim.builtin.which_key.setup.plugins.presets.motions = true

-- Toggle comments
lvim.keys.normal_mode["<C-/><C-/>"] = "<Plug>(comment_toggle_linewise_current)"
lvim.keys.normal_mode["<C-_><C-_>"] = "<Plug>(comment_toggle_linewise_current)"
lvim.keys.visual_mode["<C-/><C-/>"] = "<Plug>(comment_toggle_linewise_visual)"
lvim.keys.visual_mode["<C-_><C-_>"] = "<Plug>(comment_toggle_linewise_visual)"

-- Quick window navigation
-- for i = 1, 9, 1 do
--   lvim.keys.normal_mode["<leader>" .. i] = ":" .. i .. "wincmd w<CR>"
-- end

-- Disable arrow movement, resize splits instead.
lvim.keys.normal_mode["<Up>"] = ":resize +2<CR>"
lvim.keys.normal_mode["<Down>"] = ":resize -2<CR>"
lvim.keys.normal_mode["<Right>"] = ":vertical resize +2<CR>le"
lvim.keys.normal_mode["<Left>"] = ":vertical resize -2<CR>"


-- Move lines up/down
-- lvim has built in using Option
-- lvim.keys.visual_mode["<C-j>"] = ":m '>+1<CR>gv=gv"
-- lvim.keys.visual_mode["<C-k>"] = ":m '<-2<CR>gv=gv"
-- lvim.keys.normal_mode["<C-j>"] = ":m +<CR>"
-- lvim.keys.normal_mode["<C-k>"] = ":m -2<CR>"

-- Alias shortcuts for common tasks
lvim.builtin.which_key.mappings["o"] = { ":only<CR>:set cmdheight=1<CR>", "Close all but this" }
vim.cmd([[
  nnoremap <leader>O :w\|%bd\|e#\|bd#<CR>\'"
]])

lvim.keys.visual_mode["p"] = '"_dP' -- don't yank into clipboard when pasting
lvim.keys.normal_mode["x"] = '"_x'  -- when deleting a single character don't clobber clipboard

-- Keep selection after indenting
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })

lvim.lsp.buffer_mappings.normal_mode["<C-a>"] = { "ggVGG", "Select all" }

lvim.builtin.which_key.mappings["G"] = { "mygg=G`y", "Reindent file" } -- reindent entire file

vim.cmd([[
autocmd FileType eruby nnoremap <buffer> <leader>lf :silent !htmlbeautifier -b 2 %<CR>
autocmd FileType svg nnoremap <buffer> <leader>lf :silent !htmlbeautifier -b 2 %<CR>
]])

-- Open file in VS Code
lvim.builtin.which_key.mappings["v"] = {
  s = { ":!code --reuse-window --add '<C-r>=getcwd()<CR>' --goto '%:p':<C-r>=line('.')<CR>:<C-r>=col('.')<CR><CR>", "Open in VSCode" }
}


-- Easy Align

-- Start interactive EasyAlign in visual mode (e.g. vipga)
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.keymap.set({ "x", "n" }, "ga", "<Plug>(EasyAlign)")


vim.g["qfenter_keymap"] = {
  vopen = { '<C-v>' },
  topen = { '<C-t>' },
}

vim.g["pencil#wrapModeDefault"] = 'soft'

vim.cmd([[
augroup TrailingWhitespace
autocmd!

" Remove trailing whitespace on save
function! s:RemoveTrailingWhitespaces()
"Save last cursor position
let l = line(".")
let c = col(".")

%s/\s\+$//ge

call cursor(l,c)
endfunction

au BufWritePre * :call <SID>RemoveTrailingWhitespaces()
augroup END
]])

vim.cmd([[
" Session management
augroup sourcesession
" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif
augroup END
]])

vim.opt.autowriteall = true
vim.cmd([[
augroup autosaveEx
autocmd!

au FocusLost,BufLeave * silent! update
augroup END
]])

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    name = "codespell",
    filetypes = { "javascript", "python", "ruby", "eruby" },
  },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "prettier" },
}