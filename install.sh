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

# echo "---> Post brew"
# $(brew --prefix)/opt/fzf/install --all
# # install rust + cargo
# rustup-init -y
# echo "---> Post brew done"

echo ""
echo "---> Python / pip"
python3 ~/.dotfiles/python/install.py
echo "---> Python / pip done"

echo ""
echo "---> Golang "
python3 ~/.dotfiles/go/install.py
echo "---> Golang done"

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
echo "---> Node + NPM"
fnm install --latest
sudo ln -sfv ~/.local/share/fnm/aliases/default/bin/npm /usr/local/bin/npm
sudo ln -sfv ~/.local/share/fnm/aliases/default/bin/node /usr/local/bin/node
sudo ln -sfv ~/.local/share/fnm/aliases/default/bin/npx /usr/local/bin/npx
python3 ~/.dotfiles/node/install.py
echo "---> Yarn done"

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

echo ""
echo "---> vim"
mkdir -p ~/.config/nvim/
ln -svf ~/.dotfiles/vim/ideavimrc.vim ~/.ideavimrc

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
echo "---> term"
tic -x ~/.dotfiles/term/xterm-256color-italic.terminfo
echo "---> term done"
