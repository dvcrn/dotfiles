set incsearch

" Case-insensitive searching.
set ignorecase

" But case-sensitive if expression contains a capital letter.
set smartcase

" Default to global substitutions on lines
set gdefault

" Use the system pasteboard
set clipboard=unnamed

" Relative line numbers
set relativenumber

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
nnoremap <space>pf :xccmd openQuickly<CR>
nnoremap <space>pt :xccmd toggleNavigatorsVisibility<CR>
nnoremap <space>pc :xccmd toggleDebuggerVisibility<CR>
nnoremap <space>pF :xccmd revealInProjectNavigator<CR>

nnoremap <space>p/ :xccmd findInWorkspace<CR>

" window
nnoremap <space>wv :vsplit<CR>
nnoremap <space>w/ :vsplit<CR>
nnoremap <space>wh :split<CR>
nnoremap <space>w- :split<CR>
