# oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# zsh theme: tiny
mkdir -p ~/.oh-my-zsh/custom/themes
\curl https://raw.githubusercontent.com/leighmcculloch/zsh-theme-tiny/master/tiny.zsh-theme > ~/.oh-my-zsh/custom/themes/tiny.zsh-theme

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

# optionals
./install-go-tools.sh

# dot files
cp bash_profile ~/.bash_profile
cp gitconfig ~/.gitconfig
cp gitignore_global ~/.gitignore_global
cp gitmessage ~/.gitmessage
cp zshrc ~/.zshrc
