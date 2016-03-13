syntax on
filetype plugin indent on

set timeout timeoutlen=1000 ttimeoutlen=500

" old stuf
set nocompatible
set directory=$HOME/.vimswap//
set viewdir=$HOME/.vimviews//
set backupdir=$HOME/.vimbackup//
silent execute '!mkdir -p $HOME/.vimbackup'
silent execute '!mkdir -p $HOME/.vimviews'
silent execute '!mkdir -p $HOME/.vimswap'

" basic options
set autochdir
set laststatus=2                  " always show the status line
set cmdheight=2                   " and use a two-line tall status line
set showcmd                       " show the command
set noshowmode                    " don't show the mode, vim-airline will do that for us
set autoindent                    " turns it on
set cursorline
set smartindent                   " does the right thing (mostly) in programs
set linespace=3                   " prefer a slight higher line height
set linebreak                     " wrap intelligently, won't insert hard line breaks
set wrap                          " use line wrapping
set textwidth=79                  " at column 79
set ruler                         " display current cursor position
set list                          " show invisible characters
set showmatch                     " show matching brackets
set relativenumber                " use relative line numbers
set number                        " except for the current line - absolute number there
set mousehide                     " hide mouse when typing
set foldenable                    " enable code folding
set history=1000
set ffs=unix,mac,dos              " default file types
set autoread                      " automatically update file when editted outside of vim
set noerrorbells visualbell t_vb= " no bell

" Setup automatic text formatting/wrapping (previously: grn1 )
set formatoptions=
set formatoptions-=t              " don't autowrap text
set formatoptions+=c              " do autowrap comments
set formatoptions+=r              " automatically continue comments
set formatoptions+=o              " automatically continue comments when hitting 'o' or 'O'
set formatoptions+=q              " allow formating of comments with 'gq'
set formatoptions+=n              " recognize numbered lists
set formatoptions+=l              " don't break long lines that were already there

" Set tab stuff
set tabstop=2           " 2 spaces for a tab
set shiftwidth=2        " 2 spaces for autoindenting
set softtabstop=2       " when <BS>, pretend a tab is removed even if spaces
set expandtab           " expand tabs to spaces (overloadable by file type)

set autoread            " reload files changed on disk, i.e. via `git checkout`
set hidden              " switch beteen buffers without saving

set clipboard=unnamed   " yank and paste with the system clipboard

set gdefault            " apply substitutions globally by default. add `g` for old behavior
set hlsearch            " highlight search results
set ignorecase          " ignore case when searching
set smartcase           " ignore case if search string is all lower case, case-sensitve otherwise

" Set titlestring to current buffer
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}

" Make cursor a flat bar in insert mode
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

if exists('neovim_dot_app')
  :set noshowcmd
endif
