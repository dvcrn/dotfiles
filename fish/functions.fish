# z jump through fzf
set -e z
function z
  if test (count $argv) -gt 0
    __z "$argv"
    return 1
  end

  cd (__z -l 2>&1 | fzf-tmux +s --tac --query "$argv" | sed 's/^[0-9,.]* *//')
end
