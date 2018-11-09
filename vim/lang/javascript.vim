" packages
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
"Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'ncm2/ncm2-tern',  {'do': 'npm install', 'for': ['javascript', 'javascript.jsx']}

"let g:neomake_jsx_enabled_makers = ['eslint']


" autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

au FileType javascript nmap gd :call LanguageClient_textDocument_definition()<CR>
au FileType javascript nmap ,gd :call LanguageClient_textDocument_definition()<CR>

au FileType javascript nmap ,= :call LanguageClient_textDocument_formatting()<CR>

au FileType javascript nmap mgd :call LanguageClient_textDocument_definition()<CR>
au FileType javascript nmap m= :call LanguageClient_textDocument_formatting()<CR>
