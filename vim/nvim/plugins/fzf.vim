function! s:find_root()
  for vcs in ['.git', '.svn', '.hg']
    let dir = finddir(vcs.'/..', ';')
    if !empty(dir)
      execute 'Files' dir
      return
    endif
  endfor
  Files
endfunction

command! FZFR call s:find_root()
