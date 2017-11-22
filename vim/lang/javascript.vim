" packages
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

" always assume jsx
let g:jsx_ext_required = 0

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
