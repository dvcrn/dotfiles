set background=dark
set guifont=Hack:18
syntax enable

" silent! colorscheme Tomorrow-Night-Eighties
" silent! colorscheme Tomorrow-Night
colorscheme seoul256
" let g:solarized_termcolors=256
" silent! colorscheme solarized

" Indent guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" let g:Guifont=Hack\ Regular:h14
" let g:guifont=DejaVu Sans Mono:h14

" Neovim-qt Guifont command
command -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', "<args>") | let g:Guifont="<args>"
" Set the font to DejaVu Sans Mono:h13
:Guifont Hack:h14

if has('gui_running')
  set guifont=Hack\ Regular:h14
  :set guioptions-=m  "remove menu bar
  :set guioptions-=T  "remove toolbar
  :set guioptions-=r  "remove right-hand scroll bar
  :set guioptions-=L  "remove left-hand scroll bar
  :set guioptions-=M  " don't even source the menu script
endif
