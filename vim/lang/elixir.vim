" Plug 'Thinca/vim-ref', { 'for': 'elixir' }
" Plug 'Shougo/vimproc.vim', { 'do': 'make', 'for': 'elixir' }
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }

" Shortcut for ExDef without leader
au FileType elixir nmap gd :ExDef

au FileType elixir nmap ,gd :ExDef

au FileType elixir nmap <leader>mgd :ExDef
