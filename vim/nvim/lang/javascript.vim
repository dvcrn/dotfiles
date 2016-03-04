let g:jsx_ext_required = 0 " Use jsx in every js file

let g:syntastic_javascript_checkers = ['jslint']
let g:syntastic_javascript_jslint_args = " "

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
