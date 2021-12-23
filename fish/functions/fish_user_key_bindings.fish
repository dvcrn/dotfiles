function fish_user_key_bindings
  if type -q fzf_key_bindings
    fzf_key_bindings
  else 
    if [ -f '(brew --prefix)/opt/fzf/shell/key-bindings.fish']; . '(brew --prefix)/opt/fzf/shell/key-bindings.fish'; end
  end
end