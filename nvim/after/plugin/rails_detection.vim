autocmd FileType rubyrails
      \ if RailsDetect() | call rails#ruby_setup() | endif
autocmd FileType eruby
      \ if RailsDetect() | call rails#ruby_setup() | endif
autocmd FileType eruby.html
      \ if RailsDetect() | call rails#ruby_setup() | endif
