" markdown files
autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown setfiletype markdown
autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown set spell spelllang=en_us
autocmd FileType markdown setlocal tw=100
