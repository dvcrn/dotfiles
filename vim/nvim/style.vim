set background=dark
set guifont=Hack:18
set t_Co=256
syntax enable

" silent! colorscheme Tomorrow-Night-Eighties
silent! colorscheme Tomorrow-Night
" let g:solarized_termcolors=256
" silent! colorscheme solarized

" Indent guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

if has('gui_running')
  set guifont=Hack\ Regular:h14
endif
