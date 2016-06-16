" packages
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }


" Swift
let g:jsx_ext_required = 0 " Use jsx in every js file

let g:syntastic_javascript_checkers = ['eslint', 'jslint']
let g:syntastic_javascript_jslint_args = " "

" always assume jsx
let g:jsx_ext_required = 0

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
