Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

highlight clear SignColumn
highlight GitGutterAdd ctermfg=green guifg=darkgreen
highlight GitGutterChange ctermfg=yellow guifg=darkyellow
highlight GitGutterDelete ctermfg=red guifg=darkred
highlight GitGutterChangeDelete ctermfg=yellow guifg=darkyellow
highlight clear SignColumn " Fix odd behaviour

let g:gitgutter_map_keys = 1

nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk

nmap <Leader>gha <Plug>GitGutterStageHunk
nmap <Leader>ghu <Plug>GitGutterUndoHunk
nmap <Leader>ghp <Plug>GitGutterPreviewHunk

nmap <Leader>gn <Plug>GitGutterNextHunk
nmap <Leader>gp <Plug>GitGutterPrevHunk

nmap <Leader>gP <Plug>Gpush

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gl :Commits<CR>

