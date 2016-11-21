Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'golang']

" For TOC
let g:vmt_auto_update_on_save = 1

" markdown files
autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown setfiletype markdown
autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown set spell spelllang=en_us
autocmd FileType markdown setlocal tw=100

" Keybindings
au FileType markdown nmap <Leader>mti :silent! GenTocGFM<cr>

au FileType markdown nmap ,ti :silent! GenTocGFM<cr>
