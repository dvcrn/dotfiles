call plug#begin('~/.vim/plugged')

Plug 'neovim/node-host', { 'do': 'npm install' }

Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-fnr'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/gv.vim'

Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'

" Plug 'easymotion/vim-easymotion'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-sensible'

Plug 'jiangmiao/auto-pairs'

" Syntax
Plug 'sheerun/vim-polyglot'

Plug 'Shougo/neco-vim', {'for': 'vim'}
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'saltstack/salt-vim', { 'for': 'salt' }
Plug 'dearrrfish/vim-applescript', { 'for': 'applescript' }

Plug 'equalsraf/neovim-gui-shim'

" global function
function! DoRemote(args)
  UpdateRemotePlugins
endfunction

" control whitespace preferences based on filetype
filetype on

autocmd FileType * setlocal formatoptions-=r formatoptions-=o

" syntax of these languages is fussy over tabs Vs spaces
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType python setlocal shiftwidth=4 tabstop=4

autocmd BufEnter * silent! lcd %:p:h

" Remove whitespaces on save
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Use buffers instead of tabs with jedi
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 0

source ~/.dotfiles/vim/options.vim
source ~/.dotfiles/vim/keybindings.vim
source ~/.dotfiles/vim/style.vim

source ~/.dotfiles/vim/lang/markdown.vim
source ~/.dotfiles/vim/lang/ruby.vim
source ~/.dotfiles/vim/lang/javascript.vim
source ~/.dotfiles/vim/lang/clojure.vim
source ~/.dotfiles/vim/lang/elixir.vim
source ~/.dotfiles/vim/lang/html.vim
source ~/.dotfiles/vim/lang/go.vim

" source ~/.dotfiles/vim/plugins/airline.vim
source ~/.dotfiles/vim/plugins/fzf.vim
source ~/.dotfiles/vim/plugins/nerdtree.vim
source ~/.dotfiles/vim/plugins/hardtime.vim
source ~/.dotfiles/vim/plugins/seek.vim
source ~/.dotfiles/vim/plugins/neomake.vim
source ~/.dotfiles/vim/plugins/emoji.vim
source ~/.dotfiles/vim/plugins/goyo.vim
source ~/.dotfiles/vim/plugins/org.vim
source ~/.dotfiles/vim/plugins/multiplecursors.vim
source ~/.dotfiles/vim/plugins/slash.vim

source ~/.dotfiles/vim/plugins/deoplete.vim
source ~/.dotfiles/vim/plugins/snippets.vim
source ~/.dotfiles/vim/plugins/git.vim


call plug#end()
