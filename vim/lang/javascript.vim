" packages
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': 'javascript' }
"Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': 'javascript' }
"Plug 'wokalski/autocomplete-flow', { 'do': 'npm install -g flow-bin', 'for': 'javascript' }

Plug 'roxma/nvim-cm-tern',  {'do': 'npm install', 'for': 'javascript' }
Plug 'roxma/ncm-flow',  {'do': 'npm install -g flow-bin', 'for': 'javascript' }

let g:neomake_jsx_enabled_makers = ['eslint']

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

" always assume jsx
let g:jsx_ext_required = 0

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
