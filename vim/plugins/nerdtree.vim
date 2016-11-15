Plug 'scrooloose/nerdtree'

" NERDTree
let g:NERDTreeHijackNetrw=0

" fix nerdtree devicons
autocmd FileType nerdtree setlocal nolist

" Python files
let NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$']
autocmd BufNewFile,BufRead *.py set ts=2 sts=2 sw=2 expandtab

nnoremap <silent> <leader>pt :NERDTreeToggle<CR>   " open a horizontal split and switch to it (,h)
nnoremap <silent> <leader>pF :NERDTreeFind<CR>   " open a horizontal split and switch to it (,h)
