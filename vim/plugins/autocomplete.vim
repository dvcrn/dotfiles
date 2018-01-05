if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'roxma/nvim-completion-manager', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-completion-manager', { 'do': ':UpdateRemotePlugins' }
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'Shougo/echodoc.vim'

function UseNCM()
  set completeopt-=preview " get rid of vim complete window. Never used it, don't need it.
  inoremap <expr><C-n> pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ cm#_force_refresh()
  function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction"}}}
endfunction

" deoplete
function UseDeoplete()
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

  let g:deoplete#enable_at_startup = 1
  let g:deoplete#ignore_sources = {}
  let g:deoplete#ignore_sources._ = ['member', 'tag', 'neosnippet']
  let g:deoplete#auto_complete_delay = 0
endfunction

"call UseDeoplete()
call UseNCM()

:command UseDeoplete call UseDeoplete()
:command UseNCM call UseNCM()
