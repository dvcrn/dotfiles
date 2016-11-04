function! PostInstallVimgo(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  GoInstallBinaries
endfunction

Plug 'fatih/vim-go', { 'for': 'go', 'do': function('PostInstallVimgo') }
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
