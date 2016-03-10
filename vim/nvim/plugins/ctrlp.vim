" Control-P
" Ignore some files we don't need
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.git/,*.pyc

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

