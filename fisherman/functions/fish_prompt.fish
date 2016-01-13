# name: L
function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function _arrow
  switch $fish_bind_mode
    case default
      set_color red; echo "λ"
    case insert
      set_color blue; echo "λ"
    case visual
      set_color green; echo "λ"
  end
end

function _vim_state
  switch $fish_bind_mode
    case default
      set_color red; echo "[n]"
    case insert
      set_color blue; echo "[i]"
    case visual
      set_color green; echo "[v]"
  end
end

function fish_prompt
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)
  set -l red (set_color red)

  set -l cwd $blue(prompt_pwd)

  if [ (_git_branch_name) ]
    set git_info $green(_git_branch_name)
    set git_info ":$git_info"

    if [ (_is_git_dirty) ]
      set -l dirty "*"
      set git_info "$git_info$dirty"
    end
  end

  echo -n -s (_vim_state) ' ' $cwd $git_info $normal ' ' (_arrow) ' '
end
