set shell=/bin/bash
set encoding=utf-8

let mapleader = " "

runtime macros/matchit.vim

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/syntastic'     " Syntax error indicators
Plug 'tpope/vim-fugitive'       " Git integration
Plug 'tpope/vim-surround'       " tags/quote
Plug 'vim-scripts/tComment'     " Comment toggling
Plug 'vim-airline/vim-airline'
Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment' " Comments as text objects
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'Raimondi/delimitMate'
Plug 'terryma/vim-expand-region'
Plug 'MarcWeber/vim-addon-local-vimrc'


Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'joker1007/vim-ruby-heredoc-syntax'
Plug 'vim-scripts/ruby-matchit'
Plug 'vim-ruby/vim-ruby'
Plug 'thoughtbot/vim-rspec'
Plug 'jgdavey/vim-blockle'
Plug 'alvan/vim-closetag'
Plug 'nelstrom/vim-textobj-rubyblock'

Plug 'nginx/nginx', { 'rtp': 'contrib/vim' }

Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'alexlafroscia/postcss-syntax.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'poetic/vim-textobj-javascript'

Plug 'jparise/vim-graphql'

Plug 'junegunn/goyo.vim' " full screen writing
Plug 'reedes/vim-pencil'

call plug#end()

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set number        " Always show line numbers
set nocursorline
set nocursorcolumn
set nostartofline " Keep the cursor on the same column
set ttyfast
set lazyredraw
set nowrap
set autoread
set switchbuf=usetab
set spell
set autoindent
set smartindent
set showmatch     " Show matching pair of [] () {}
set scrolloff=10

if &t_Co > 2 || has("gui_running")
  if (has("termguicolors"))
    set termguicolors
  endif

  set t_Co=256
  set t_AB=^[[48;5;%dm
  set t_AF=^[[38;5;%dm
  let base16colorspace=256
  set hlsearch
  "This unsets the "last search pattern" register by hitting return
  nnoremap <CR> :noh<CR><CR>
  set background=dark

  let g:airline_powerline_fonts = 0

  let g:airline_section_a = airline#section#create(['mode'])
  let g:airline_section_y = airline#section#create_right([ '# %{winnr()}' ])
  let g:airline_section_z = "%M %#__accent_bold#%4l/%L%#__restore__# %{g:airline_symbols.linenr} %3v"
  let g:airline_skip_empty_sections = 1
  let g:airline#extensions#tabline#enabled = 0

  if filereadable(expand("~/.vimrc_background"))
    source ~/.vimrc_background
  endif

  " Dark background "oceanicnext"
  " Light background "mexico-light"

  " Use the same color for closing tags as opening tags
  highlight link xmlEndTag xmlTag
endif

" Autosave
set autowriteall  " Save when switching buffers
augroup autosaveEx
  autocmd!

  au FocusLost,BufLeave * silent! :wa
augroup END

" Softtabs, 2 spaces
set shiftround
set expandtab
set textwidth=79
set formatoptions-=t
set formatoptions+=2c
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Numbers
set number
set numberwidth=5

" Window/tab management
set splitbelow
set splitright


" tell it to use an undo file
set undofile
" you:uuuuset a directory to store the undo history
set undodir=$HOME/.vimundo/

augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

if has('mouse')
  set mouse=a
  " set ttymouse=xterm2
endif

nnoremap <leader>rc :tabe $MYVIMRC<cr>
nnoremap <leader>q :q<CR>
nnoremap <leader>o :only<CR>
nnoremap <leader>n :cn<CR>

" Make it easy to move around in insert mode
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l

" Keep selection after indenting
vnoremap < <gv
vnoremap > >gv
nnoremap <C-a> ggVGG

" Quick window navigation
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile

" Expand spaces inside brackets/parens
let delimitMate_expand_space=1


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  command! -nargs=+ -complete=file Ag silent! grep! <args>|cwindow|redraw!
endif

augroup nerdTreeEx
  autocmd!

  " Toggle nerdtree with F10
  map <F10> :NERDTreeToggle<CR>

  map <F9> :NERDTreeFind<CR>

  let NERDTreeMapOpenInTab='<C-t>'
augroup END

augroup TrailingWhitespace
  autocmd!

  " Remove trailing whitespace on save for ruby files.
  function! s:RemoveTrailingWhitespaces()
    "Save last cursor position
    let l = line(".")
    let c = col(".")

    %s/\s\+$//ge

    call cursor(l,c)
  endfunction

  au BufWritePre * :call <SID>RemoveTrailingWhitespaces()
augroup END


augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile Atlasfile set filetype=ruby
  autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json

  " Open markdown files with Chrome.
  autocmd BufEnter *.md exe 'noremap <F5> :!open -a "Google Chrome.app" ''%:p''<CR>'
  command! Md Goyo | SoftPencil


  let &titlestring = getcwd()
  if &term == "screen"
    set t_ts=^[k
    set t_fs=^[\
  endif
  if &term == "screen" || &term == "xterm" || &term == "xterm-256color" || &term == "nvim"
    set title
  endif
augroup END

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Snippets
let g:UltiSnipsSnippetsDir='~/.vim/mysnippets'
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsJumpForwardTrigger="<tab>"

"key to insert mode with paste using F2 key
map <F2> :set paste<CR>i
" Leave paste mode on exit
au InsertLeave * set nopaste
" Use OSX clipboard
set clipboard=unnamed

" FZF
nnoremap <leader>/ :BLines<CR>
nnoremap <C-P> :FZF<CR>
nnoremap , :Buffers<CR>
let $FZF_DEFAULT_COMMAND='ag -g ""'

" Ruby
let g:ruby_indent_access_modifier_style = 'indent'
let g:ruby_indent_block_style = 'do'
let g:ruby_indent_assignment_style = 'hanging'

" Rails

map <leader>t :call RunCurrentSpecFile()<CR>
map <leader>s :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>a :call RunAllSpecs()<CR>
map <leader>x :bd! .rspec-output<CR>
map <space><space> :bd! .rspec-output<CR>
map <leader>r :AV<CR>

if has('nvim')
  let g:rspec_command = "silent! bd! .rspec-output | bo 30split | enew | call termopen( \"cd $(find `( SPEC='{spec}'; CP=${SPEC\\%/*}; while [ -n \\\"$CP\\\" ] ; do echo $CP;  CP=${CP\\%/*}; done; echo / ) ` -mindepth 1 -maxdepth 1 -type d -name spec); echo 'Running specs...'; cd ..; bin/rspec {spec}\" ) | set bufhidden=hide | file .rspec-output"
else
  let g:rspec_command = "!cd $(find `( SPEC='{spec}'; CP=${SPEC\\%/*}; while [ -n \"$CP\" ] ; do echo $CP; CP=${CP\\%/*}; done; echo / ) ` -mindepth 1 -maxdepth 1 -type d -name spec)/..; echo 'Running specs...'; bin/rspec {spec}"
endif

let g:rails_console_command = "echo no command set"
nnoremap <leader>c :silent! bd! .rails-console \| bo 30split \| enew \| file .rails-console \| call termopen( g:rails_console_command ) \| set bufhidden=hide<CR>
nnoremap <leader>m :silent! bd! .console \| bo 30split \| enew \| file .console \| term bash -l<CR>



" Javascript
let g:jsx_ext_required = 0

let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js,*.jsx"
let g:closetag_emptyTags_caseSensitive = 1

augroup jsSyntastic
  autocmd!

  function! FindEsLint()
    let a:src = expand( '%:p' )
    let a:cmd = 'cd $( find `( SPEC=''' . a:src . '''; CP=${SPEC%/*}; while [ -n "$CP" ] ; do echo $CP; CP=${CP%/*}; done; echo / )` -mindepth 1 -maxdepth 1 -type d -name node_modules ); pwd'
    let a:node_modules = StrTrim( system( a:cmd ) )

    let b:syntastic_javascript_eslint_exec = a:node_modules . '/.bin/eslint'
  endfunction

  function! StrTrim(txt)
    return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
  endfunction

  autocmd FileType javascript call FindEsLint()
augroup END

" GIT
nnoremap <leader>d :!cd %:h; git dt %:p<CR>

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntatsic_filetype_map = { "javascript.jsx": "javascript" }
" let g:syntastic_debug = 63
" let g:syntastic_debug_file = "~/syntastic.log"

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

let g:syntastic_javascript_checkers = ["eslint"]

let g:syntastic_ruby_checkers = [ 'rubocop' ]
let g:syntastic_ruby_rubocop_args = '-D -S'


" Python
let python_highlight_all=1
augroup pythonEx
  autocmd!

  " https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
  au FileType python set tabstop=4
  au FileType python set softtabstop=4
  au FileType python set shiftwidth=4

augroup END

filetype plugin indent on

" Support per-project .vimrc commands
set exrc
set secure
