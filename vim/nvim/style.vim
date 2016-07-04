Plug 'chriskempson/vim-tomorrow-theme'
Plug 'marciomazza/vim-brogrammer-theme'
Plug 'sjl/badwolf'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'

set background=dark
set guifont=Hack:18

syntax enable

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

" Indent guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

if has('gui_running')
  set guifont=Source\ Code\ Pro:h16
  :set guioptions-=m  "remove menu bar
  :set guioptions-=T  "remove toolbar
  :set guioptions-=r  "remove right-hand scroll bar
  :set guioptions-=L  "remove left-hand scroll bar
  :set guioptions-=M  " don't even source the menu script
endif

autocmd BufRead * RainbowParentheses
