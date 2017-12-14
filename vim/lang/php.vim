Plug 'phpactor/phpactor' ,  {'do': 'composer install'}
Plug 'roxma/ncm-phpactor'

" [g]o [d]definition
au FileType php nmap <Leader>mgd :call phpactor#GotoDefinition()<CR>
au FileType php nmap <Leader>mc :call phpactor#ContextMenu()<CR>
au FileType php nmap <Leader>mi :call phpactor#OffsetTypeInfo()<CR>

au FileType php nmap ,gd :call phpactor#GotoDefinition()<CR>
au FileType php nmap ,c :call phpactor#ContextMenu()<CR>
au FileType php nmap ,i :call phpactor#OffsetTypeInfo()<CR>

" Shortcuts
au FileType php nmap gd :call phpactor#GotoDefinition()<CR>

" map <Leader>u :call phpactor#UseAdd()<CR>
" map <Leader>e :call phpactor#ClassExpand()<CR>
" map <Leader>pp :call phpactor#ContextMenu()<CR>
" map <Leader>pd :call phpactor#OffsetTypeInfo()<CR>
" map <Leader>pfm :call phpactor#MoveFile()<CR>
" map <Leader>pfc :call phpactor#CopyFile()<CR>
" map <Leader>tt :call phpactor#Transform()<CR>
" map <Leader>cc :call phpactor#ClassNew()<CR>
" map <Leader>fr :call phpactor#FindReferences()<CR>
"
" " Show information about "type" under cursor including current frame
" nnoremap <silent><Leader>d :call phpactor#OffsetTypeInfo()<CR>

autocmd FileType php setlocal shiftwidth=4 tabstop=4 expandtab
