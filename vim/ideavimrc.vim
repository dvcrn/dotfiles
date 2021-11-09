" to find actions in intellij, use :actionlist [pattern]"
set incsearch

" Case-insensitive searching.
set ignorecase

" But case-sensitive if expression contains a capital letter.
set smartcase

" Default to global substitutions on lines
set gdefault

set surround
set highlightedyank
set textobj-entire

set ideajoin
set ideamarks

" Use the system pasteboard
set ideaput
set clipboard+=unnamed

" Make it so mode stays the same when refactoring or using templates
set idearefactormode=keep

" relative line numbers
set relativenumber
set number

" Make c-j to act the same as c-n
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

nnoremap <C-j> <C-n>
nnoremap <C-k> <C-p>

vnoremap <C-j> <C-n>
vnoremap <C-k> <C-p>

nnoremap Q <nop>

" unsplit with C-w
nnoremap <C-w>q :action Unsplit<CR>

" better esc
imap fd <esc>
vno v <esc>

nnoremap <silent> <leader>/ :nohlsearch<CR>

" project based keybindings
nnoremap <space>pf :action GotoFile<CR>
nnoremap <space>pF :action SelectInProjectView<CR>
nnoremap <space>bb :action RecentFiles<CR>
nnoremap <C-b> :action RecentFiles<CR>
nnoremap <space>pt :action ActivateProjectToolWindow<CR>
nnoremap <space>pc :action NewFile<CR>

nnoremap ,r :action RenameElement<CR>
nnoremap ,R :action RefactoringMenu<CR>

" window
nnoremap <space>wv :vsplit<CR>
nnoremap <space>wl :vsplit<CR>
nnoremap <space>wh :split<CR>
nnoremap <space>wj :split<CR>

" meta
nnoremap <space>_r :source ~/.ideavimrc<CR>
