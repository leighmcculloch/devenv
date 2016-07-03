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
./optionals/install-go-user.sh
./optionals/install-ruby-user.sh
./optionals/install-swift-user.sh

# dot files
cp home/.gitconfig ~/
cp home/.gitignore_global ~/
cp home/.gitmessage ~/
cp home/.zshrc ~/

# set zsh as default shell
chsh -s /bin/zsh
