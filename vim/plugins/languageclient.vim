Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': './install.sh'
      \ }

" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_hoverPreview = "Never"

" Implementations
" Go: https://github.com/saibing/bingo
" Elixir: https://github.com/JakeBecker/elixir-ls (see https://github.com/autozimu/LanguageClient-neovim/issues/234)

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'go': ['bingo', '--format-style', 'goimports'],
    \ 'elixir': ['eli-ls']
    \ }

"
" Automatic Hover
" function! DoNothingHandler(output)
" endfunction
"
" function! IsDifferentHoverLineFromLast()
"   if !exists('b:last_hover_line')
"     return 1
"   endif
"
"   return b:last_hover_line !=# line('.') || b:last_hover_col !=# col('.')
" endfunction
"
" function! GetHoverInfo()
"   " Only call hover if the cursor position changed.
"   "
"   " This is needed to prevent infinite loops, because hover info is displayed
"   " in a popup window via nvim_buf_set_lines() which puts the cursor into the
"   " popup window and back, which in turn calls CursorMoved again.
"   if mode() == 'n' && IsDifferentHoverLineFromLast()
"     let b:last_hover_line = line('.')
"     let b:last_hover_col = col('.')
"
"     call LanguageClient_textDocument_hover()
"     " the following line will create a vertical split
"     " call LanguageClient_textDocument_hover({'handle': v:true}, 'DoNothingHandler')
"     " call LanguageClient_clearDocumentHighlight()
"     " call LanguageClient_textDocument_documentHighlight({'handle': v:true}, 'DoNothingHandler')
"   endif
" endfunction
"
" augroup LanguageClient_config
"   autocmd!
"   autocmd CursorMoved * call GetHoverInfo()
"   autocmd CursorMovedI * call LanguageClient_clearDocumentHighlight()
" augroup end
