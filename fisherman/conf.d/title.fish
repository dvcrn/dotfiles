set -x LAST_COMMAND "none"
set -x LAST_TITLE "none"

function fish_title
    echo $_ ' '
    pwd

    set -x LAST_COMMAND $argv[1]
    set -x LAST_TITLE $_
end

function tmux_pane_title -v LAST_TITLE
  printf "\033k$LAST_TITLE\033\\"
end
