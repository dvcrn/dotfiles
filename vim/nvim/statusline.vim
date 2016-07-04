set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P

function! Emojify()
  silent! if emoji#available()
    let s:ft_emoji = map({
      \ 'c':          'baby_chick',
      \ 'clojure':    'lollipop',
      \ 'coffee':     'coffee',
      \ 'cpp':        'chicken',
      \ 'css':        'art',
      \ 'eruby':      'ring',
      \ 'gitcommit':  'soon',
      \ 'haml':       'hammer',
      \ 'help':       'angel',
      \ 'html':       'herb',
      \ 'java':       'older_man',
      \ 'javascript': 'monkey',
      \ 'make':       'seedling',
      \ 'markdown':   'book',
      \ 'perl':       'camel',
      \ 'python':     'snake',
      \ 'ruby':       'gem',
      \ 'scala':      'barber',
      \ 'sh':         'shell',
      \ 'slim':       'dancer',
      \ 'text':       'books',
      \ 'vim':        'poop',
      \ 'vim-plug':   'electric_plug',
      \ 'yaml':       'yum',
      \ 'yaml.jinja': 'yum'
    \ }, 'emoji#for(v:val)')

    function! S_filetype()
      if empty(&filetype)
        return emoji#for('grey_question')
      else
        return get(s:ft_emoji, &filetype, '['.&filetype.']')
      endif
    endfunction

    function! S_modified()
      if &modified
        return emoji#for('kiss').' '
      elseif !&modifiable
        return emoji#for('construction').' '
      else
        return ''
      endif
    endfunction

    function! S_fugitive()
      if !exists('g:loaded_fugitive')
        return ''
      endif
      let head = fugitive#head()
      if empty(head)
        return ''
      else
        return head == 'master' ? emoji#for('crown') : emoji#for('dango').'='.head
      endif
    endfunction

    let s:braille = split('"⠉⠒⠤⣀', '\zs')
    function! Braille()
      let len = len(s:braille)
      let [cur, max] = [line('.'), line('$')]
      let pos  = min([len * (cur - 1) / max([1, max - 1]), len - 1])
      return s:braille[pos]
    endfunction

    hi def link User1 TablineFill
    let s:cherry = emoji#for('cherry_blossom')
    function! MyStatusLine()
      let mod = '%{S_modified()}'
      let ro  = "%{&readonly ? emoji#for('lock') . ' ' : ''}"
      let ft  = '%{S_filetype()}'
      let fug = ' %{S_fugitive()}'
      let sep = ' %= '
      let pos = ' %l,%c%V '
      let pct = ' %P '

      return s:cherry.' [%n] %F %<'.mod.ro.ft.fug.sep.pos.'%{Braille()}%*'.pct.s:cherry
    endfunction

    " Note that the "%!" expression is evaluated in the context of the
    " current window and buffer, while %{} items are evaluated in the
    " context of the window that the statusline belongs to.
    set statusline=%!MyStatusLine()
  endif
endfunction

" autocmd VimEnter * call Emojify()
