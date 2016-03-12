autocmd FileType clojure setlocal shiftwidth=4 tabstop=4

autocmd FileType clojure nnoremap <Leader>mp :let parinfer_mode = "paren"<CR>:echo 'Switched to paren mode'<CR>
autocmd FileType clojure nnoremap <Leader>mi :let parinfer_mode = "indent"<CR>:echo 'Switched to indent mode'<CR>

" Same again but without leader
autocmd FileType clojure nnoremap ,p :let parinfer_mode = "paren"<CR>:echo 'Switched to paren mode'<CR>
autocmd FileType clojure nnoremap ,i :let parinfer_mode = "indent"<CR>:echo 'Switched to indent mode'<CR>

autocmd FileType clojure :echo 'activated clojure mode.'
