call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'goldfeld/vim-seek'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-sensible'

Plug 'jiangmiao/auto-pairs'
Plug 'rking/ag.vim'

" Flash yanks
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'

" Hard mode to get rid of habits
Plug 'dvcrn/hardmode'
Plug 'kbarrette/mediummode'
Plug 'takac/vim-hardtime'

" Style related packages
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'marciomazza/vim-brogrammer-theme'
Plug 'sjl/badwolf'
Plug 'altercation/vim-colors-solarized'

Plug 'nathanaelkane/vim-indent-guides'
" Plug 'powerline/powerline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'bling/vim-bufferline' " Show buffers in statusline

" Syntax
Plug 'scrooloose/syntastic'
Plug 'dvcrn/vim-niji'

" javascript
Plug 'mxw/vim-jsx'

" Clojure
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'fwolanski/vim-clojure-conceal', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'snoe/nvim-parinfer.js'

" Swift
Plug 'keith/swift.vim'

" Ruby
Plug 'vim-ruby/vim-ruby'

call plug#end()

" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" control whitespace preferences based on filetype
filetype on

autocmd FileType * setlocal formatoptions-=r formatoptions-=o

" syntax of these languages is fussy over tabs Vs spaces
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType python setlocal shiftwidth=4 tabstop=4

autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml " treat .rss files as XML

autocmd BufRead COMMIT_EDITMSG setlocal spell spelllang=en_us " spell check Git commit messages
autocmd BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't') " start commit message in insert mode

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

let g:clojure_conceal_extras = 1 " Lambda concealing for vim

let g:ycm_autoclose_preview_window_after_insertion = 1 " YCM

source ~/.dotfiles/vim/nvim/options.vim
source ~/.dotfiles/vim/nvim/style.vim
source ~/.dotfiles/vim/nvim/keybindings.vim

source ~/.dotfiles/vim/nvim/lang/markdown.vim
source ~/.dotfiles/vim/nvim/lang/ruby.vim
source ~/.dotfiles/vim/nvim/lang/javascript.vim

source ~/.dotfiles/vim/nvim/plugins/ctrlp.vim
source ~/.dotfiles/vim/nvim/plugins/syntastic.vim
source ~/.dotfiles/vim/nvim/plugins/nerdtree.vim
source ~/.dotfiles/vim/nvim/plugins/fugitive.vim
source ~/.dotfiles/vim/nvim/plugins/airline.vim
source ~/.dotfiles/vim/nvim/plugins/gitgutter.vim
source ~/.dotfiles/vim/nvim/plugins/mediummode.vim
source ~/.dotfiles/vim/nvim/plugins/hardtime.vim
source ~/.dotfiles/vim/nvim/plugins/seek.vim
