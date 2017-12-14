Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'zchee/deoplete-go', { 'do': 'make' }

" options for deoplete
let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Use goimports over gofmt
let g:go_fmt_command = "goimports"

let g:neomake_go_gobuild_maker = {
    \ 'exe': 'sh',
    \ 'args': ['-c', 'go build -o /dev/null ./\$0', '%:h'],
    \ 'errorformat':
        \ '%W%f:%l: warning: %m,' .
        \ '%E%f:%l:%c:%m,' .
        \ '%E%f:%l:%m,' .
        \ '%C%\s%\+%m,' .
        \ '%-G#%.%#'
\ }

" Automatically GoInstall go projects to make gocode work
" autocmd FileType go :silent autocmd BufWritePost :GoInstall

" [g]o [d]definition
au FileType go nmap <Leader>mgds <Plug>(go-def-split)
au FileType go nmap <Leader>mgdv <Plug>(go-def-vertical)
au FileType go nmap <Leader>mgdt <Plug>(go-def-tab)

" e[x]ecute
au FileType go nmap <leader>mxr <Plug>(go-run)
au FileType go nmap <leader>mxb <Plug>(go-build)
au FileType go nmap <leader>mxt <Plug>(go-test)
au FileType go nmap <leader>mxc <Plug>(go-coverage)

" [d]ocumentation
au FileType go nmap <Leader>mdh <Plug>(go-doc)
au FileType go nmap <Leader>mdv <Plug>(go-doc-vertical)

" [i]nfo
au FileType go nmap <Leader>mi <Plug>(go-info)

" [r]ename
au FileType go nmap <Leader>mr <Plug>(go-rename)

" [t]ags
au FileType go nmap <Leader>mt :GoAddTags<space>

" [b]build, [i]nstall
au FileType go nmap <Leader>mi :GoInstall<space>
au FileType go nmap <Leader>mb :GoBuild<space>


" -- everything again for ,
" TODO: learn vimscript and combine them

" [g]o [d]definition
au FileType go nmap ,gds <Plug>(go-def-split)
au FileType go nmap ,gdv <Plug>(go-def-vertical)
au FileType go nmap ,gdt <Plug>(go-def-tab)

" e[x]ecute
au FileType go nmap ,xr <Plug>(go-run)
au FileType go nmap ,xb <Plug>(go-build)
au FileType go nmap ,xt <Plug>(go-test)
au FileType go nmap ,xc <Plug>(go-coverage)

" [d]ocumentation
au FileType go nmap ,dh <Plug>(go-doc)
au FileType go nmap ,dv <Plug>(go-doc-vertical)

" [i]nfo
au FileType go nmap ,i <Plug>(go-info)

" [r]ename
au FileType go nmap ,r <Plug>(go-rename)

" [t]ags
au FileType go nmap ,t :GoAddTags<space>

" [b]build, [i]nstall
au FileType go nmap <Leader>,i :GoInstall<space>
au FileType go nmap <Leader>,b :GoBuild<space>
