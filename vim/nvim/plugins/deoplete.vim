Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

let g:deoplete#enable_at_startup = 1

" Tab navigation
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<C-k>"
