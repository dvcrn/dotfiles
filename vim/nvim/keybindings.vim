:let mapleader = "\<Space>"

" Move line(s) up or down via C-j and C-k respectively

" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Tab navigation
nnoremap ‘ :bnext<CR> " alt-right-square-bracket
nnoremap “ :bprevious<CR> " alt-left-square-bracket
nnoremap ≈ :bp\|bd #<CR> " alt-x

" use <C>hjkl to switch between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" also space hjkl
nnoremap <Leader>h <C-w>h<CR>
nnoremap <Leader>l <C-w>l<CR>
nnoremap <Leader>j <C-w>j<CR>
nnoremap <Leader>k <C-w>k<CR>

nnoremap Q <nop>

cmap w!! w !sudo tee > /dev/null %

noremap <Leader>ti :set list!<CR> " Toggle special characters
noremap <Leader>tl :set relativenumber!<CR> " Toggle relative line numbers

" fix Vim's regex handling
nnoremap / /\v
vnoremap / /\v

" Paste stuff
set pastetoggle=<F5>
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" Map escape to jj -- much faster to reach and type
imap jj <esc>
imap jk <esc>
imap kj <esc>
imap fd <esc>
vno v <esc>

" Searching
" remove search highlighting with <F3>
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Splits
nnoremap <leader>wv <C-w>v<C-w>l   " split vertically
nnoremap <leader>wh <C-w>s<C-w>j   " split horizontally
