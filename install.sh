echo "Installing all your stuff!"
echo ""

# Brew
echo ""
echo "---> Brew"
brew tap Homebrew/bundle
cd ~/.dotfiles/brew/ && brew bundle
cd ~/.dotfiles/
echo "---> Brew done"

echo "---> Post brew"
/usr/local/opt/fzf/install --all
echo "---> Post brew done"

echo ""
echo "---> Git"
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global
echo "---> Git done"

echo ""
echo "---> Python / pip"
pip install -r ~/.dotfiles/pip/packages.txt
echo "---> Python / pip done"

echo ""
echo "---> NPM"
python ~/.dotfiles/npm/install.py
echo "---> NPM done"

echo ""
echo "---> tmux"
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
echo "---> tmux done"

echo ""
echo "---> vim"
# ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc
# ln -s ~/.dotfiles/vim/.gvimrc ~/.gvimrc
# ln -s ~/.dotfiles/vim/.ideavimrc ~/.ideavimrc
mkdir -p ~/.config/nvim/
ln -s ~/.dotfiles/vim/nvim/.nvimrc ~/.config/nvim/init.vim
ln -s ~/.dotfiles/vim/nvim/.nvimrc ~/.vimrc
ln -s ~/.dotfiles/vim/nvim/.nvimrc ~/.gvimrc
ln -s ~/.dotfiles/vim/nvim/.nvimrc ~/.ideavimrc
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
echo "---> kwm"
mkdir -p ~/.kwm/
ln -s ~/.dotfiles/kwm/kwmrc ~/.kwm/kwmrc
echo "---> kwm done"

echo ""
echo "---> fish"
mkdir -p ~/.config/
ln -s ~/.dotfiles/fisherman ~/.config/fisherman
echo "---> fish done"

echo ""
echo "---> peco"
mkdir -p ~/.config/peco/
ln -s ~/.dotfiles/peco/config.json ~/.config/peco/config.json
echo "---> peco done"
