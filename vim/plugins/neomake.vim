Plug 'neomake/neomake'

function! MyOnBattery()
  return readfile('/tmp/on_battery') == ['0']
endfunction

function! InitNeomake()
  if MyOnBattery()
    call neomake#configure#automake('w')
  else
    call neomake#configure#automake('nw', 1000)
  endif
endfunction

autocmd VimEnter * :call InitNeomake()
