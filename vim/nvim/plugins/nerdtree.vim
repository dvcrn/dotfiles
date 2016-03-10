" NERDTree
let g:NERDTreeHijackNetrw=0

" Python files
let NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$']
autocmd BufNewFile,BufRead *.py set ts=2 sts=2 sw=2 expandtab
