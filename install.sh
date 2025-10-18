# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `this script` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo "Installing all your stuff!"
echo ""

mkdir -p ~/.config/

echo ""
echo "---> Git"
ln -svf ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -svf ~/.dotfiles/git/gitignore_global ~/.gitignore_global
echo "---> Git done"

echo ""
echo "---> ssh"
if test -f "~/.ssh/config"; then
	mv ~/.ssh/config ~/.ssh/config.bak
fi
ln -svf ~/.dotfiles/ssh/config ~/.ssh/config
echo "---> ssh done"

# Starship
echo ""
echo "---> Starship"
ln -svf ~/.dotfiles/starship/starship.toml ~/.config/starship.toml

# Brew
echo ""
echo "---> Brew"
brew tap Homebrew/bundle
cd ~/.dotfiles/brew/ && brew bundle
cd ~/.dotfiles/
echo "---> Setting autoupdate"
brew autoupdate start
echo "---> Brew done"

echo "---> mise (languages)"
mise i node elixir go erlang rust python
mise use -g node elixir go erlang rust python
eval "$(mise activate zsh)"

echo "----> Install bun"
mise use -g bun@latest
mise use -g uv


echo ""
echo "---> fish"
ln -svf ~/.dotfiles/fish ~/.config/fish

echo "---> adding fish as default shell"
if ! grep -q "$(which fish)" "/etc/shells"
then
  sudo sh -c "echo '$(which fish)' >> /etc/shells"
fi
chsh -s "$(which fish)"
echo "---> fish done"

echo ""
echo "---> tmux"
ln -svf ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
tic -x ~/.dotfiles/tmux/tmux.terminfo
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "---> tmux done"

echo ""
echo "---> Ghostty"
mkdir -p ~/.config/ghostty/
ln -svf ~/.dotfiles/ghostty/config ~/.config/ghostty/config
echo "---> Ghostty done"

# lua vim
ln -svf ~/.dotfiles/luavim/init.lua ~/.config/nvim/init.lua
ln -svf ~/.dotfiles/luavim/lua ~/.config/nvim/lua
# mkdir -p ~/.local/share/nvim/site/pack/packer/start/
# git clone --depth 1 git@github.com:wbthomason/packer.nvim.git ~/.local/share/nvim/site/pack/packer/start/packer.nvim
echo "---> vim done"

echo ""
echo "---> zed"
ln -svf ~/.dotfiles/zed ~/.config/zed
echo "---> zed done"

echo ""
echo "---> helix"
ln -svf ~/.dotfiles/helix ~/.config/helix
echo "---> helix done"

echo ""
echo "---> sublime text"
mkdir -p ~/Library/Application\ Support/Sublime\ Text/Packages/
ln -svfh ~/.dotfiles/sublimetext/ ~/Library/Application\ Support/Sublime\ Text/Packages/User
echo "---> sublime text done"

echo ""
echo "---> sublime merge"
mkdir -p /Users/david/Library/Application\ Support/Sublime\ Merge/Packages/
ln -svfh ~/.dotfiles/sublimemerge/ ~/Library/Application\ Support/Sublime\ Merge/Packages/User
echo "---> sublime text done"

echo ""
echo "---> Claude CLI"
ln -svf ~/.dotfiles/llm/claude/.claude ~/.claude
echo "---> Claude CLI done"

# echo ""
# echo "---> LLM configs (VSCode integrations)"

# CLINE_SETTINGS_SRC="$HOME/.dotfiles/llm/cline"
# ROO_SETTINGS_SRC="$HOME/.dotfiles/llm/roo"

# # --- Standard VS Code ---
# VSCODE_STD_BASE="$HOME/Library/Application Support/Code/User/globalStorage"
# CLAUDE_STD_TARGET="$VSCODE_STD_BASE/saoudrizwan.claude-dev/settings"
# ROO_STD_TARGET="$VSCODE_STD_BASE/rooveterinaryinc.roo-cline/settings"

# if [ -d "$HOME/Library/Application Support/Code" ]; then
#   echo "Processing Standard VS Code settings..."
#   mkdir -p "$(dirname "$CLAUDE_STD_TARGET")"
#   mkdir -p "$(dirname "$ROO_STD_TARGET")"

#   if [ -e "$CLAUDE_STD_TARGET" ] || [ -L "$CLAUDE_STD_TARGET" ]; then
#     echo "Backing up existing standard Claude settings..."
#     rm -rf "$CLAUDE_STD_TARGET.bak"
#     mv "$CLAUDE_STD_TARGET" "$CLAUDE_STD_TARGET.bak"
#   fi
#   ln -svf "$CLINE_SETTINGS_SRC" "$CLAUDE_STD_TARGET"

#   if [ -e "$ROO_STD_TARGET" ] || [ -L "$ROO_STD_TARGET" ]; then
#     echo "Backing up existing standard Roo settings..."
#     rm -rf "$ROO_STD_TARGET.bak"
#     mv "$ROO_STD_TARGET" "$ROO_STD_TARGET.bak"
#   fi
#   ln -svf "$ROO_SETTINGS_SRC" "$ROO_STD_TARGET"
# else
#   echo "Standard VS Code directory not found, skipping."
# fi

echo "---> LLM configs done"

echo ""
echo "---> term"
tic -x ~/.dotfiles/term/xterm-256color-italic.terminfo
echo "---> term done"
