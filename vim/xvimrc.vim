set incsearch

" Case-insensitive searching.
set ignorecase

" But case-sensitive if expression contains a capital letter.
set smartcase

" Default to global substitutions on lines
set gdefault

" Use the system pasteboard
set pasteboard

" Make c-j to act the same as c-n
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

nnoremap <C-j> <C-n>
nnoremap <C-k> <C-p>

vnoremap <C-j> <C-n>
vnoremap <C-k> <C-p>

nnoremap Q <nop>

" fix Vim's regex handling
nnoremap / /\v
vnoremap / /\v

" better esc
imap fd <esc>
vno v <esc>

nnoremap <silent> <leader>/ :nohlsearch<CR>

" project based keybindings
nnoremap <space>pf :xccmd openQuickly<CR>
