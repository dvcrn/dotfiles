call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'neovim/node-host', { 'do': 'npm install' }

Plug 'scrooloose/nerdtree'
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-fnr'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-easy-align'

Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'goldfeld/vim-seek'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-sensible'

Plug 'jiangmiao/auto-pairs'

" Flash yanks
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'

" Hard mode to get rid of habits
Plug 'dvcrn/hardmode'
Plug 'kbarrette/mediummode'
Plug 'takac/vim-hardtime'


" Style related packages
Plug 'nathanaelkane/vim-indent-guides'

Plug 'chriskempson/vim-tomorrow-theme'
Plug 'marciomazza/vim-brogrammer-theme'
Plug 'sjl/badwolf'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'


" Syntax
Plug 'benekastah/neomake'
" Plug 'scrooloose/syntastic'
Plug 'junegunn/rainbow_parentheses.vim'

Plug 'keith/swift.vim', { 'for': 'swift' }

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

source ~/.dotfiles/vim/nvim/lang/markdown.vim
source ~/.dotfiles/vim/nvim/lang/ruby.vim
source ~/.dotfiles/vim/nvim/lang/javascript.vim
source ~/.dotfiles/vim/nvim/lang/clojure.vim

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
source ~/.dotfiles/vim/nvim/plugins/neomake.vim
source ~/.dotfiles/vim/nvim/plugins/emoji.vim

call plug#end()

source ~/.dotfiles/vim/nvim/style.vim
source ~/.dotfiles/vim/nvim/statusline.vim
