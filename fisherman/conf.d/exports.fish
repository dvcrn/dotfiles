set -x LANG "en_US.UTF-8"
set -x LC_COLLATE "en_US.UTF-8"
set -x LC_CTYPE "en_US.UTF-8"
set -x LC_MESSAGES "en_US.UTF-8"
set -x LC_MONETARY "en_US.UTF-8"
set -x LC_NUMERIC "en_US.UTF-8"
set -x LC_TIME "en_US.UTF-8"
set -x LC_ALL

set -x PATH (brew --prefix)"/bin:$PATH"
set -x DEVELOPER_DIR "/Applications/Xcode.app/Contents/Developer/"
#set -x PYTHONPATH (brew --prefix)"/lib/python2.7/site-packages:$PYTHONPATH"

set -x VISUAL atom
set -x EDITOR nvim
set -x TERM xterm-256color

function serve
  python -m SimpleHTTPServer 8000
end

function activate
  if test -d venv
    source venv/bin/activate
  else if test -d ../venv
    source ../venv/bin/activate
  end
end

function act
  activate
end

function ggc
  git branch --remote | grep $argv[1] | sed 's/origin\///g' | xargs git checkout
end

function gsb
  git branch --all | grep $argv[1] | sed 's/remotes\/origin\///g' | sed 's/\*/ /g'  | sort -u | uniq
end

function emacs
  set number (ps aux | grep Emacs | wc -l)

  if test $number -gt 1
    reattach-to-user-namespace emacsclient -n $argv[1]
  else
    reattach-to-user-namespace open -a /usr/local/Cellar/emacs-mac/emacs-24.5-z-mac-5.13/Emacs.app $argv[1]
  end
end

function vim
  reattach-to-user-namespace nvim $argv[1]
end

function vi
  reattach-to-user-namespace nvim $argv[1]
end

function markright
  open -a /Applications/MarkRight.app
end
