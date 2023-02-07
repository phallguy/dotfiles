set nocompatible
set encoding=utf-8
set shell=/bin/bash

let g:loaded_perl_provider = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing Experience
"
let mapleader = " "

set nobackup
set nowritebackup
set noswapfile     " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
" set backupcopy=yes " Overwrite existing file so file watchers can detect changes
set noendofline     " Don't automatically add newline
set nofixendofline
set updatecount=0
set title

set cursorline      " Makes vim refresh much slower
set nocursorcolumn
set laststatus=2
set foldmethod=marker

" https://neovim.io/news/2022/04#filetypelua
let g:do_filetype_lua = 1
"let g:did_load_filetypes = 0


set hlsearch
set incsearch
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

set showcmd
set nostartofline " Keep the cursor on the same column
set lazyredraw    " Don't redraw screen while executing macros and such.
set nowrap

" Softtabs, 2 spaces
set shiftround
set expandtab
set textwidth=79
set formatoptions-=t
set formatoptions+=2c
set tabstop=2
set softtabstop=2
set shiftwidth=2
set preserveindent

" Line Numbers
set number        " Always show line numbers
set numberwidth=3

set undofile                " tell it to use an undo file
set undodir=$HOME/.vimundo/ " use a directory to store the undo history


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"
call plug#begin('~/.vim/plugged')
Plug 'MarcWeber/vim-addon-local-vimrc' " import .vimrc from CWD when launching

" Visual experience
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lilydjwg/colorizer'
Plug 'kevinhwang91/nvim-bqf'
Plug 'blueyed/vim-qf_resize'

" General editing
Plug 'tpope/vim-commentary'
Plug 'mg979/vim-visual-multi'
Plug 'junegunn/vim-easy-align'  " Multi-line bock alignment
Plug 'tpope/vim-surround'       " change surrounding tags/quotes/parens
Plug 'SirVer/ultisnips'         " Code snippets
Plug 'ervandew/supertab'
Plug 'reedes/vim-pencil'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'mbbill/undotree'
Plug 'vim-scripts/LargeFile'

" Searching & navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-vinegar'
Plug 'yssl/QFEnter'

" Git/status
Plug 'tpope/vim-fugitive'       " Git integration
Plug 'tpope/vim-rhubarb'        " More GitHub integration

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Language support
"
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'janko/vim-test'
Plug 'tpope/vim-dispatch'       " Async test runner to quick fix
Plug 'kana/vim-textobj-user'    " Custom 'object' targeting for movements
Plug 'glts/vim-textobj-comment' " Comments as text objects
Plug 'dense-analysis/ale'       " Code formatting

" Ruby/rails
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'joker1007/vim-ruby-heredoc-syntax'
Plug 'andymass/vim-matchup'

" Javasript
Plug 'leafgarland/typescript-vim'
Plug 'kchmck/vim-coffee-script'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'

" Dart
" Plug 'dart-lang/dart-vim-plugin'

" Markdown
Plug 'preservim/vim-markdown'

" Arduino
" Plug 'sudar/vim-arduino-syntax'
" Plug 'sudar/vim-arduino-snippets'

" iOS
Plug 'keith/swift.vim'
"

" Python
" Plug 'vim-scripts/indentpython.vim'
" Plug 'Glench/Vim-Jinja2-Syntax'

" Terraform
Plug 'hashivim/vim-terraform'

" Android
Plug 'udalov/kotlin-vim'

call plug#end()

filetype on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting and visual styling
"
if &t_Co > 2 || has("gui_running")

  " Support 24-bit colors if possible
  if (has("termguicolors"))
    set termguicolors
  endif

  set background=dark

if exists('$BASE16_THEME')
      \ && (!exists('g:colors_name') || g:colors_name != 'base16-$BASE16_THEME')
    let base16colorspace=256
    colorscheme base16-$BASE16_THEME

    let base16colorspace=256  " Access colors present in 256 colorspace
    call Base16hi("SignColumn", g:base16_gui03, g:base16_gui00, g:base16_cterm03, g:base16_cterm00, "none", "")
    call Base16hi("LineNr", g:base16_gui01, g:base16_gui00, g:base16_cterm01, g:base16_cterm00, "none", "")
    call Base16hi("CursorLineNr", g:base16_gui04, g:base16_gui02, g:base16_cterm02, g:base16_cterm00, "none", "")
    call Base16hi("CursorLine",    "", g:base16_gui02, "", g:base16_cterm02, "none", "")
    call Base16hi("MatchParen",    "", g:base16_gui01, "", g:base16_cterm01, "none", "")

    call Base16hi("Folded", g:base16_gui0C, "", g:base16_cterm03, g:base16_cterm02, "none", "")

    call Base16hi("BqfPreviewBorder", g:base16_gui0B, g:base16_gui00, g:base16_cterm0B, g:base16_cterm00, "none", "")

    call Base16hi("QuickFixLine", g:base16_gui07, g:base16_gui0D, g:base16_cterm0B, g:base16_cterm00, "none", "")
    call Base16hi("qfSeparator", g:base16_gui01, g:base16_gui00, g:base16_cterm01, g:base16_cterm00, "none", "")

    com! CheckHighlightUnderCursor echo {l,c,n ->
          \   'hi<'    . synIDattr(synID(l, c, 1), n)             . '> '
          \  .'trans<' . synIDattr(synID(l, c, 0), n)             . '> '
          \  .'lo<'    . synIDattr(synIDtrans(synID(l, c, 1)), n) . '> '
          \ }(line("."), col("."), "name")
  endif


  let g:airline_extensions = ['fugitiveline', 'ale', 'fzf']
  let g:airline_powerline_fonts = 1
  let g:airline_theme='base16_vim'
  let g:airline_section_a = airline#section#create([ 'mode' ])
  let g:airline#extensions#branch#format = 2
  let g:airline#extensions#branch#displayed_head_limit = 24
  " let g:airline_section_y = airline#section#create_right([ '#%{winnr()}' ])
  " let g:airline_section_z = "%M %#__accent_bold#%4l/%L%#__restore__# %{g:airline_symbols.linenr} %3v"
  let g:airline_section_y = ""
  let g:airline_section_z = ""
  let g:airline_skip_empty_sections = 1
  let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

  let g:airline_highlighting_cache = 1
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline#extensions#ale#enabled = 1

  let g:colorizer_startup = 0
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "ruby", "javascript", "markdown", "hcl", "json" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
    },

  matchup = {
    enable = true,
    disable = {},
    },

  incremental_selection = {
    enable = true
    },

  indent = {
    enable = false
    }
  }
EOF

nnoremap + :lua require'nvim-treesitter.incremental_selection'.init_selection()<CR>
xnoremap + :lua require'nvim-treesitter.incremental_selection'.node_incremental()<CR>
xnoremap _ :lua require'nvim-treesitter.incremental_selection'.node_decremental()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window/navigation
"

" Window/tab management
set splitbelow
set splitright

set scrolloff=10     " Keep 10 lines at top/bottom of window when scrolling
set sidescrolloff=10

" Leave paste mode on exit
au InsertLeave * set nopaste

" Alias shortcuts for common tasks
nnoremap <leader>rc :tabe $MYVIMRC<cr>
nnoremap <leader>q :q<CR>
nnoremap <leader>o :only<CR>:set cmdheight=1<CR>
nnoremap <leader>O :w\|%bd\|e#\|bd#<CR>\'"
nnoremap <leader>n :cn<CR>
nnoremap <leader>p :cp<CR>
nnoremap <leader>c :cw<CR>

lua <<EOF
require('bqf').setup({
auto_enable = true,
preview = {
  win_height = 15,
  win_vheight = 15,
  delay_syntax = 80,
  show_title = false,
  }
})
EOF

let g:qf_resize_max_ratio=0.25
let g:qf_resize_max_height=30
let g:qf_resize_min_height=5

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General editing commands.
"

" Cliboards
set clipboard=unnamedplus " Use OSX clipboard

" Move lines up/down
nnoremap <C-k> :m-2<CR>
nnoremap <C-j> :m+<CR>
vnoremap <C-j> :m '>+1<CR>gv
vnoremap <C-k> :m '<-2<CR>gv

" Keep selection after indenting
vnoremap < <gv
vnoremap > >gv
nnoremap <C-a> ggVGG

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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

set autowriteall    " Save when switching buffers

augroup autosaveEx
  autocmd!

  au FocusLost,BufLeave * silent! update
augroup END

" Snippets
let g:UltiSnipsSnippetsDir='~/.vim/mysnippets'
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsJumpForwardTrigger="<tab>"

" Word wrapping
let g:pencil#wrapModeDefault = 'soft'

" Code formatting
"
let g:ale_fixers = {
      \   'javascript': ['prettier', 'eslint'],
      \   'javascriptreact': ['prettier', 'eslint'],
      \   'coffee': ['prettier', 'eslint'],
      \   'typescript': ['prettier', 'eslint'],
      \   'html': ['prettier'],
      \   'json': ['prettier', 'eslint'],
      \   'css': ['prettier'],
      \   'scss': ['prettier'],
      \   'ruby': ['rubocop'],
      \   'dart': ['dartfmt'],
      \   'python': ['autopep8'],
      \}

let g:ale_linters = {
      \   'ruby': ['rubocop'],
      \}

let g:ale_ruby_rubocop_options = '--extra-details --display-style-guide'

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%] %code: %%s [%linter%]'
let g:ale_detail_to_floating_preview = 1
let g:ale_floating_preview = 1
let g:ale_virtualtext_cursor = 0


map <leader>f :ALEFix<CR>
map <leader>a :ALELint<CR>

" Re-indent entire file
map <leader>g mygg=G`y
autocmd FileType eruby nnoremap <buffer> <leader>g :!htmlbeautifier -b 2 %<CR>
autocmd FileType svg nnoremap <buffer> <leader>g :!htmlbeautifier -b 2 %<CR>


" Toggle comments
nnoremap <C-_><C-_> :Commentary<CR>
vnoremap <C-_><C-_> <Plug>Commentary \| gv


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching & file navigation
"

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor\ --path-to-ignore\ .agignore

  command! -nargs=+ -complete=file Ag silent! grep! <args>|cwindow|redraw!
endif

" FZF
nnoremap <leader>/ :BLines<CR>
nnoremap <C-P> :FZF<CR>
nnoremap , :Buffers<CR>
nnoremap <leader>, <C-6>
let $FZF_DEFAULT_COMMAND='ag -g "" --path-to-ignore .agignore'
let g:fzf_preview_window = ''

let g:qfenter_keymap = {
      \   "vopen": ['<C-v>'],
      \   "topen": ['<C-t>'],
      \}

" Matchup
let g:matchup_matchparen_offscreen = {'method': 'popup'}


" Disable arrow movement, resize splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>le
nnoremap <Left>  :vertical resize -2<CR>

" " Move through soft wrapped lines like regular lines
" nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
" nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Quick window navigation
let i = 1
while i <= 9
  execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
  let i = i + 1
endwhi

augroup netwr
  autocmd!

  let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" _er file/syntax customization

augroup syntaxOverrides
  autocmd!

  autocmd BufRead,BufNewFile Jakefile,*.jake,*.ejs set filetype=javascript
  autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
  autocmd BufRead,BufNewFile Dockerfile.ejs set filetype=dockerfile
  autocmd BufRead,BufNewFile *.yaml.ejs set filetype=yaml
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile *.aurora set filetype=python
  autocmd BufRead,BufNewFile tsconfig.json set filetype=typescript
  autocmd BufRead,BufNewFile .envrc set filetype=sh
augroup END

" Use the same color for closing tags as opening tags
highlight link xmlEndTag xmlTag

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'
let g:html_indent_inctags = 'html,body,head,tbody,p'
let g:closetag_filetypes = 'html,xhtml,phtml,eruby'

" Git
augroup gitEx
  autocmd!

  au FileType gitcommit set tw
  au FileType gitcommit set spell
  au FileType gitcommit PencilSoft
  au FileType git setlocal foldmethod=syntax
augroup END

" Show diff of current file in external tool
nnoremap <leader>gd :!cd %:h; git dt %:p<CR>

" VIMRC
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Markdown
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

" Ruby/Rails
map <leader>t :TestFile<CR>
map <leader>s :TestNearest<CR>
map <leader>l :TestLast<CR>
map <leader>d :cclose<CR>:TestNearest -strategy=neovim<CR>
map <leader>r :AV<CR>

let test#ruby#use_spring_binstub = 0
let g:test#preserve_screen = 0
let g:test#neovim#start_normal = 0
let g:test#echo_command = 0
let test#filename_modifier = ':p'

if has('nvim')
  let test#strategy = "dispatch"
  let test#neovim#term_position = "botright 30"
end

let g:ruby_indent_access_modifier_style="indent"
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_hanging_args=0
let g:splitjoin_ruby_trailing_comma=1
let g:splitjoin_normalize_whitespace=1
let g:splitjoin_align=1
let g:splitjoin_ruby_options_as_arguments=1

let g:rails_projections = {
\  "app/controllers/*_controller.rb": {
\      "test": [
\        "spec/requests/{}_controller_spec.rb",
\        "spec/controllers/{}_controller_spec.rb",
\        "test/controllers/{}_controller_test.rb"
\      ],
\      "alternate": [
\        "spec/requests/{}_controller_spec.rb",
\        "spec/controllers/{}_controller_spec.rb",
\        "test/controllers/{}_controller_test.rb"
\      ],
\   },
\   "spec/requests/*_spec.rb": {
\      "command": "request",
\      "alternate": "app/controllers/{}.rb",
\      "template": "require 'rails_helper'\n\n" .
\        "RSpec.describe '{}' do\nend",
\   },
\ }

augroup subProjectRoot
  autocmd!

  " For mono-repo projects, dynamically look for package.json or Gemfile to
  " find the 'root' to run tests and ale linters from
  function! SetTestRoot()
    let src = expand( '%:p' )
    let cmd = 'dirname $( find `( SPEC=''' . src . '''; CP=${SPEC%/*}; while [ -n "$CP" ] ; do echo $CP; CP=${CP%/*}; done; echo / )` -mindepth 1 -maxdepth 1 -type f -name Gemfile -o -name package.json | head -n 1 )'
    let g:test#project_root = StrTrim( system( cmd ) )
    let g:project_root = StrTrim( system( cmd ) )
    let g:ale_command_wrapper = 'cd ' . g:project_root . '; '

    echo g:project_root
  endfunction

  function! StrTrim(txt)
    return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
  endfunction

  autocmd BufEnter,BufWinEnter,FileType javascript call SetTestRoot()
  autocmd BufEnter,BufWinEnter,FileType javascriptreact call SetTestRoot()
  autocmd BufEnter,BufWinEnter,FileType typescript call SetTestRoot()
"    autocmd BufEnter,BufWinEnter,FileType ruby call SetTestRoot()

augroup END

" JavaScript


" Python
augroup pythonsettings
  autocmd!

  au BufNewFile,BufRead *.py
        \ set tabstop=4 |
        \ set softtabstop=4 |
        \ set shiftwidth=4 |
        \ set textwidth=99 |
        \ set expandtab |
        \ set autoindent |
        \ set fileformat=unix
augroup END

let python_highlight_all=1

" Support per-project .vimrc commands
set exrc
set secure