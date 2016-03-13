" Packages
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'fwolanski/vim-clojure-conceal', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'snoe/nvim-parinfer.js', { 'for': 'clojure' }


let g:clojure_conceal_extras = 1 " Lambda concealing for vim

autocmd FileType clojure setlocal shiftwidth=4 tabstop=4

autocmd FileType clojure nnoremap <Leader>mp :let parinfer_mode = "paren"<CR>:echo 'Switched to paren mode'<CR>
autocmd FileType clojure nnoremap <Leader>mi :let parinfer_mode = "indent"<CR>:echo 'Switched to indent mode'<CR>

" Same again but without leader
autocmd FileType clojure nnoremap ,p :let parinfer_mode = "paren"<CR>:echo 'Switched to paren mode'<CR>
autocmd FileType clojure nnoremap ,i :let parinfer_mode = "indent"<CR>:echo 'Switched to indent mode'<CR>

autocmd FileType clojure :echo 'activated clojure mode.'
