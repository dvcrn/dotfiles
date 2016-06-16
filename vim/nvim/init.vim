call plug#begin('~/.vim/plugged')

Plug 'neovim/node-host', { 'do': 'npm install' }

Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-fnr'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/gv.vim'

Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-sensible'

Plug 'jiangmiao/auto-pairs'

Plug 'kassio/neoterm'
Plug 'hkupty/nvimux'
Plug 'airblade/vim-rooter'

" Flash yanks
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'

" Hard mode to get rid of habits
Plug 'dvcrn/hardmode'

" Style related packages
Plug 'nathanaelkane/vim-indent-guides'

" Syntax
Plug 'sheerun/vim-polyglot'
" Plug 'scrooloose/syntastic'
Plug 'junegunn/rainbow_parentheses.vim'

Plug 'keith/swift.vim', { 'for': 'swift' }

Plug 'equalsraf/neovim-gui-shim'

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

let g:ycm_autoclose_preview_window_after_insertion = 1 " YCM

source ~/.dotfiles/vim/nvim/options.vim
source ~/.dotfiles/vim/nvim/keybindings.vim
source ~/.dotfiles/vim/nvim/statusline.vim
source ~/.dotfiles/vim/nvim/style.vim

source ~/.dotfiles/vim/nvim/lang/markdown.vim
source ~/.dotfiles/vim/nvim/lang/ruby.vim
source ~/.dotfiles/vim/nvim/lang/javascript.vim
source ~/.dotfiles/vim/nvim/lang/clojure.vim
source ~/.dotfiles/vim/nvim/lang/elixir.vim
source ~/.dotfiles/vim/nvim/lang/html.vim
source ~/.dotfiles/vim/nvim/lang/go.vim

" source ~/.dotfiles/vim/nvim/plugins/airline.vim
" source ~/.dotfiles/vim/nvim/plugins/fzf.vim
" source ~/.dotfiles/vim/nvim/plugins/ctrlp.vim
source ~/.dotfiles/vim/nvim/plugins/syntastic.vim
source ~/.dotfiles/vim/nvim/plugins/nerdtree.vim
source ~/.dotfiles/vim/nvim/plugins/fugitive.vim
source ~/.dotfiles/vim/nvim/plugins/gitgutter.vim
source ~/.dotfiles/vim/nvim/plugins/mediummode.vim
source ~/.dotfiles/vim/nvim/plugins/hardtime.vim
source ~/.dotfiles/vim/nvim/plugins/seek.vim
" source ~/.dotfiles/vim/nvim/plugins/sneak.vim
source ~/.dotfiles/vim/nvim/plugins/neomake.vim
source ~/.dotfiles/vim/nvim/plugins/emoji.vim
source ~/.dotfiles/vim/nvim/plugins/goyo.vim
source ~/.dotfiles/vim/nvim/plugins/org.vim

source ~/.dotfiles/vim/nvim/plugins/ycm.vim
source ~/.dotfiles/vim/nvim/plugins/snippets.vim


call plug#end()
