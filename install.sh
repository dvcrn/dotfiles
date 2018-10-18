echo "Installing all your stuff!"
echo ""

echo ""
echo "---> ssh"
ln -s ~/.dotfiles/ssh/config ~/.ssh/config
echo "---> ssh done"

echo ""
echo "---> bash"
if [ ! -e ~/.git-prompt.sh ]; then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
fi

if [ ! -e ~/.jg ]; then
  # jg bins. Since my bashrc is inspired by his, I am using his binaries as
  # well
  git clone https://github.com/junegunn/dotfiles.git ~/.jg
fi

ln -svf ~/.dotfiles/bash/bashrc ~/.bashrc
ln -svf ~/.dotfiles/bash/bash_profile ~/.bash_profile
ln -svf ~/.dotfiles/bash/git.bash ~/.git.bash

# scripts
mkdir -p ~/bin
for bin in ~/.jg/bin/*; do
  ln -svf $bin ~/bin
done
echo "---> bash done"

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
ln -s ~/.dotfiles/vim/UltiSnips/ ~/.config/nvim/UltiSnips
ln -s ~/.dotfiles/vim/init.vim ~/.vimrc
ln -s ~/.dotfiles/vim/init.vim ~/.gvimrc
ln -s ~/.dotfiles/vim/ideavimrc.vim ~/.ideavimrc
ln -s ~/.dotfiles/vim/xvimrc.vim ~/.xvimrc
echo "---> vim plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "---> vim done"

echo ""
echo "---> spacemacs"
ln -s ~/.dotfiles/spacemacs/.spacemacs ~/.spacemacs
echo "---> spacemacs done"

echo ""
echo "---> proton"
ln -s ~/.dotfiles/proton/.proton ~/.proton
echo "---> proton done"

echo ""
echo "---> sublimious"
ln -s ~/.dotfiles/sublimious/.sublimious ~/.sublimious
echo "---> sublimious done"

echo ""
echo "---> term"
tic -x ~/.dotfiles/term/xterm-256color-italic.terminfo
echo "---> term done"

