Plug 'chriskempson/vim-tomorrow-theme'
Plug 'marciomazza/vim-brogrammer-theme'
Plug 'sjl/badwolf'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'

syntax enable
set background=dark

" trial & error. These 3 lines seem to cause most of the performance problems I
" was experiencing. Adding these here reduces most of that rendering lag.
syntax sync minlines=256
set nocursorcolumn
set re=1

" silent! colorscheme Tomorrow-Night-Eighties
" silent! colorscheme Tomorrow-Night
autocmd VimEnter * colorscheme seoul256
" let g:solarized_termcolors=256
" silent! colorscheme solarized

" make comments italic
autocmd VimEnter * highlight Comment cterm=italic

" Indent guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

autocmd BufRead * RainbowParentheses

