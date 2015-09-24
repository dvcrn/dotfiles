set -g WAHOO_PATH $HOME/.wahoo
set -g WAHOO_CUSTOM $HOME/.dotfiles
source $WAHOO_PATH/init.fish

fish_vi_mode

function my_vi_bindings
  fish_vi_key_bindings
  bind -M insert -m default fd backward-char force-repaint
end
set -g fish_key_bindings my_vi_bindings

function fish_greeting
		fortune -a
end