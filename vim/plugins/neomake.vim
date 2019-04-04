Plug 'neomake/neomake'

function! MyOnBattery()
  return readfile('/tmp/on_battery') == ['1']
endfunction

function! InitNeomake()
  if MyOnBattery()
    call neomake#configure#automake('w')
  else
    call neomake#configure#automake('nrwi', 1000)
  endif
endfunction

autocmd VimEnter * :call InitNeomake()

noremap ]q :lne<CR>
noremap [q :lp<CR>
