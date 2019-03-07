" Plug 'Thinca/vim-ref', { 'for': 'elixir' }
" Plug 'Shougo/vimproc.vim', { 'do': 'make', 'for': 'elixir' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }

let g:elixir_use_markdown_for_docs = 1

" Shortcut for ExDef without leader
"au FileType elixir nmap gd :ExDef<CR>
au FileType elixir nmap gd :call LanguageClient_textDocument_definition()<CR>

"au FileType elixir nmap ,gd :ExDef<CR>
au FileType elixir nmap ,gd :call LanguageClient_textDocument_definition()<CR>
au FileType elixir nmap ,= :call LanguageClient_textDocument_formatting()<CR>

"au FileType elixir nmap mgd :ExDef<CR>
au FileType elixir nmap mgd :call LanguageClient_textDocument_definition()<CR>
au FileType elixir nmap m= :call LanguageClient_textDocument_formatting()<CR>
