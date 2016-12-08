Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/echodoc.vim'

set completeopt-=preview " get rid of vim complete window. Never used it, don't need it.

let g:deoplete#enable_at_startup = 1
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['member', 'tag', 'neosnippet']
let g:deoplete#auto_complete_delay = 0

inoremap <expr><C-n> pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ deoplete#mappings#manual_complete()
		function! s:check_back_space() abort "{{{
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
		endfunction"}}}


" no new line after hitting enter
inoremap <silent><expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"

" Use partial fuzzy matches like YouCompleteMe
au VimEnter * call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
au VimEnter * call deoplete#custom#set('_', 'converters', ['converter_remove_paren'])
au VimEnter * call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])
