Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': './install.sh'
      \ }

" Required for operations modifying multiple buffers like rename.
set hidden

" Implementations
" Go: https://github.com/sourcegraph/go-langserver
" Elixir: https://github.com/JakeBecker/elixir-ls (see https://github.com/autozimu/LanguageClient-neovim/issues/234)

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'go': ['go-langserver'],
    \ 'elixir': ['eli-ls']
    \ }
