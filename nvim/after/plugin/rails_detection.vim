if exists("*RailsDetect")
autocmd BufRead,BufNewFile,BufEnter *		if RailsDetect() | call rails#ruby_setup() | endif
autocmd FileType eruby
      \ if RailsDetect() | call rails#ruby_setup() | endif
endif 
