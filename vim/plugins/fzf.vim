Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

autocmd VimEnter * command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--skip-vcs-ignores --ignore "node_modules"', <bang>0)
