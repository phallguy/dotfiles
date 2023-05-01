autocmd FileType ruby
      \ if RailsDetect() | call rails#ruby_setup() | endif
autocmd FileType eruby
      \ if RailsDetect() | call rails#ruby_setup() | endif
