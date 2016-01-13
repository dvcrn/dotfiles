# name: L
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_char_upstream_prefix ""
set -g __fish_git_prompt_char_upstream_suffix ""
set -g __fish_git_prompt_hide_untrackedfiles 1
set -g __fish_git_prompt_char_upstream_ahead "⇡"
set -g __fish_git_prompt_char_upstream_behind "⇣"
set -g __fish_git_prompt_char_untrackedfiles "*"
set -g __fish_git_prompt_char_dirtystate "+"
set -g __fish_git_prompt_char_stagedstate "."
set -g __fish_git_prompt_char_cleanstate ""
set -g __fish_git_prompt_char_stateseparator ""
set -g __fish_git_prompt_char_upstream_prefix ""

function _arrow
  switch $fish_bind_mode
    case default
      set_color red; echo "λ"
    case insert
      set_color magenta; echo "λ"
    case visual
      set_color green; echo "λ"
  end
end

function _vim_state
  switch $fish_bind_mode
    case default
      set_color red; echo "[n]"
    case insert
      set_color magenta; echo "[i]"
    case visual
      set_color green; echo "[v]"
  end
end

function _git_state
  #echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
  echo (__fish_git_prompt " " | tr -d ")" | tr -d "(" | tr -d " ")
end

function fish_prompt
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)
  set -l red (set_color red)

  set -l cwd $blue(prompt_pwd)

  echo $cwd $normal(_git_state)
  echo -n -s (_vim_state) ' ' (_arrow) ' ' $normal
end
