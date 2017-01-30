set incsearch

" Case-insensitive searching.
set ignorecase

" But case-sensitive if expression contains a capital letter.
set smartcase

" Default to global substitutions on lines
set gdefault

set vim-surround

" Use the system pasteboard
set clipboard

" Make c-j to act the same as c-n
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

nnoremap <C-j> <C-n>
nnoremap <C-k> <C-p>

vnoremap <C-j> <C-n>
vnoremap <C-k> <C-p>

nnoremap Q <nop>

" better esc
imap fd <esc>
vno v <esc>

nnoremap <silent> <leader>/ :nohlsearch<CR>

" project based keybindings
nnoremap <space>pf :action GotoFile<CR>

" window
nnoremap <space>wv :vsplit<CR>
nnoremap <space>wh :split<CR>
