# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `this script` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo "Installing all your stuff!"
echo ""

mkdir -p ~/.config/

echo ""
echo "---> ssh"
ln -s ~/.dotfiles/ssh/config ~/.ssh/config
echo "---> ssh done"

echo "---> bash"
ln -svf ~/.dotfiles/bash/bashrc ~/.bashrc
ln -svf ~/.dotfiles/bash/bash_profile ~/.bash_profile
ln -svf ~/.dotfiles/bash/git.bash ~/.git.bash

if ! grep -q /usr/local/bin/bash "/etc/shells"
then
  sudo sh -c "echo '/usr/local/bin/bash' >> /etc/shells"
fi

if [ ! -e ~/.git-prompt.sh ]; then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
fi
echo "---> bash done"

# Starship
echo ""
echo "---> Starship"
ln -s ~/.dotfiles/starship/starship.toml ~/.config/starship.toml


# Brew
echo ""
echo "---> Brew"
brew tap Homebrew/bundle
cd ~/.dotfiles/brew/ && brew bundle
cd ~/.dotfiles/
echo "---> Brew done"

echo "---> Post brew"
$(brew --prefix)/opt/fzf/install
echo "---> Post brew done"

echo ""
echo "---> Git"
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global
echo "---> Git done"

echo ""
echo "---> Python / pip"
pip3 install -r ~/.dotfiles/pip/packages.txt
echo "---> Python / pip done"

echo ""
echo "---> Go "
bash ~/.dotfiles/go/install.sh
echo "---> Go done"

echo ""
echo "---> fish"
ln -s ~/.dotfiles/fish ~/.config/fish
echo "---> fish done"

if ! grep -q /usr/local/bin/fish "/etc/shells"
then
  sudo sh -c "echo '/usr/local/bin/fish' >> /etc/shells"
fi
chsh -s /usr/local/bin/fish

echo ""
echo "---> NPM"
python ~/.dotfiles/npm/install.py
echo "---> NPM done"

echo ""
echo "---> tmux"
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
tic -x ~/.dotfiles/tmux/tmux.terminfo
echo "---> tmux done"

echo ""
echo "---> Kitty"
mkdir -p ~/.config/kitty/
ln -s ~/.dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
echo "---> Kitty done"

echo ""
echo "---> vim"
mkdir -p ~/.config/nvim/
ln -s ~/.dotfiles/vim/init.vim ~/.config/nvim/init.vim
ln -s ~/.dotfiles/vim/ginit.vim ~/.config/nvim/ginit.vim
ln -s ~/.dotfiles/vim/UltiSnips ~/.config/nvim/UltiSnips
ln -s ~/.dotfiles/vim/init.vim ~/.vimrc
ln -s ~/.dotfiles/vim/init.vim ~/.gvimrc
ln -s ~/.dotfiles/vim/ideavimrc.vim ~/.ideavimrc
ln -s ~/.dotfiles/vim/xvimrc.vim ~/.xvimrc
echo "---> vim plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "---> vim done"

echo ""
echo "---> emacs"
ln -s ~/.dotfiles/emacs ~/.emacs.d

echo ""
echo "---> spacemacs"
ln -s ~/.dotfiles/spacemacs/.spacemacs ~/.spacemacs
echo "---> spacemacs done"

echo ""
echo "---> proton"
ln -s ~/.dotfiles/proton/.proton ~/.proton
echo "---> proton done"

echo ""
echo "---> sublime text"
ln -s ~/.dotfiles/sublimetext/ /Users/d/Library/Application\ Support/Sublime\ Text/Packages/User
echo "---> sublime text done"

echo ""
echo "---> term"
tic -x ~/.dotfiles/term/xterm-256color-italic.terminfo
echo "---> term done"

