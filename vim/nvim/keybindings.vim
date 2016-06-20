:let mapleader = "\<Space>"

" Move line(s) up or down via C-j and C-k respectively

"" Normal mode
" nnoremap <C-j> :m .+1<CR>==
" nnoremap <C-k> :m .-2<CR>==
"
" " Insert mode
" inoremap <C-j> <ESC>:m .+1<CR>==gi
" inoremap <C-k> <ESC>:m .-2<CR>==gi
"
" " Visual mode
" vnoremap <C-j> :m '>+1<CR>gv=gv
" vnoremap <C-k> :m '<-2<CR>gv=gv

" Make c-j to act the same as c-n
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

nnoremap <C-j> <C-n>
nnoremap <C-k> <C-p>

vnoremap <C-j> <C-n>
vnoremap <C-k> <C-p>

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

" always flash yank motion
map y <Plug>(operator-flashy)

" for when I forget sudo
cmap w!! w !sudo tee > /dev/null %

" fix Vim's regex handling
nnoremap / /\v
vnoremap / /\v

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Paste stuff
" map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
set pastetoggle=<F5>

" remap esc to something that is faster
" imap jj <esc>
" imap jk <esc>
" imap kj <esc>
imap fd <esc>
vno v <esc>

" remap ESC to exit insert mode in terminal
" tnoremap <Esc> <C-\><C-n>

" Searching
" remove search highlighting with <F3>
nnoremap <silent> <leader>/ :nohlsearch<CR>

" -------- space based keybindings
" meta
nnoremap <leader>_i :PlugInstall<CR>
nnoremap <leader>_c :PlugClean<CR>
nnoremap <leader>_u :PlugUpdate<CR>
nnoremap <leader>_U :PlugUpgrade<CR>

" project
nnoremap <silent> <leader>pt :NERDTreeToggle<CR>   " open a horizontal split and switch to it (,h)
nnoremap <silent> <leader>pF :NERDTreeFind<CR>   " open a horizontal split and switch to it (,h)
nnoremap <leader>pf :GitFiles<CR>
nnoremap <leader>p/ :Ag<CR>
nnoremap <leader>pr :History<CR>

" window
nnoremap <leader>wv <C-w>v<C-w>l   " split vertically
nnoremap <leader>wh <C-w>s<C-w>j   " split horizontally

" file
nnoremap <leader>ff :Files<CR>

" buffer
nnoremap <Leader><Tab> :e#<CR> " switch to last buffer
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>b/ :Lines<CR>
nnoremap <leader>bl :BLines<CR>

" toggles
noremap <Leader>ti :set list!<CR>:echo 'Toggled special characters'<CR>" Toggle special characters
noremap <Leader>tl :set relativenumber!<CR>:echo 'Toggled relative line numbers'<CR>" Toggle relative line numbers
noremap <Leader>tm :MediumModeToggle<CR>:echo 'Toggled medium mode'<CR>" Toggle medium mode
noremap <Leader>tH :call ToggleHardMode()<CR>:echo 'Toggled hardmode'<CR>" Toggle hard mode
noremap <Leader>th :HardTimeToggle<CR>:echo 'Toggled hardtime'<CR>" Toggle hard time
noremap <Leader>tg :Goyo<CR>:echo 'Toggled Goyo'<CR>" Toggle goyo time

" git
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gl :Commits<CR>

" mode keybindings are inside each langs file
