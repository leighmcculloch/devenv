# oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# zsh theme: enormous
mkdir -p ~/.oh-my-zsh/custom/themes
\curl https://raw.githubusercontent.com/leighmcculloch/zsh-theme-enormous/master/enormous.zsh-theme > ~/.oh-my-zsh/custom/themes/enormous.zsh-theme

# tmux dot files
git clone --recursive https://github.com/leighmcculloch/tmux_dotfiles.git ~/.tmux_dotfiles
cd ~/.tmux_dotfiles
make install
cd -

# vim dot files
git clone https://github.com/leighmcculloch/vim_dotfiles.git ~/.vim_dotfiles
cd ~/.vim_dotfiles
make install
cd -

# dot files
cp $(dirname $0)/bash_profile ~/.bash_profile
cp $(dirname $0)/gitconfig ~/.gitconfig
cp $(dirname $0)/gitignore_global ~/.gitignore_global
cp $(dirname $0)/gitmessage ~/.gitmessage
cp $(dirname $0)/zshrc ~/.zshrc

# Setup go path if go is installed
if [ -z "$GOPATH" ]; then :; else
  mkdir -p $GOPATH_USER/src/github.com/"$USER"
fi
