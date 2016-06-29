Plug 'airblade/vim-gitgutter'

highlight clear SignColumn
highlight GitGutterAdd ctermfg=green guifg=darkgreen
highlight GitGutterChange ctermfg=yellow guifg=darkyellow
highlight GitGutterDelete ctermfg=red guifg=darkred
highlight GitGutterChangeDelete ctermfg=yellow guifg=darkyellow
highlight clear SignColumn " Fix odd behaviour

let g:gitgutter_map_keys = 1

nmap <Leader>gha <Plug>GitGutterStageHunk
nmap <Leader>ghu <Plug>GitGutterUndoHunk
nmap <Leader>ghp <Plug>GitGutterPreviewHunk

nmap <Leader>gn <Plug>GitGutterNextHunk
nmap <Leader>gp <Plug>GitGutterPrevHunk
