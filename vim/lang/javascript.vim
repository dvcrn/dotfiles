" packages
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

" Swift
let g:syntastic_javascript_checkers = ['eslint', 'jslint']
let g:syntastic_javascript_jslint_args = " "

" always assume jsx
let g:jsx_ext_required = 0

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
