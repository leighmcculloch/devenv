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

# install go tools
export GOPATH="$HOME/go"
go get github.com/nsf/gocode
go get github.com/alecthomas/gometalinter
go get golang.org/x/tools/cmd/goimports
go get golang.org/x/tools/cmd/guru
go get golang.org/x/tools/cmd/gorename
go get github.com/golang/lint/golint
go get github.com/rogpeppe/godef
go get github.com/kisielk/errcheck
go get github.com/jstemmer/gotags
go get github.com/klauspost/asmfmt/cmd/asmfmt
go get github.com/fatih/motion
go get github.com/zmb3/gogetdoc
go get github.com/josharian/impl
go get github.com/mailgun/godebug

# dot files
cp /usr/local/sbin/adduser/bash_profile ~/.bash_profile
cp /usr/local/sbin/adduser/gitconfig ~/.gitconfig
cp /usr/local/sbin/adduser/gitignore_global ~/.gitignore_global
cp /usr/local/sbin/adduser/gitmessage ~/.gitmessage
cp /usr/local/sbin/adduser/zshrc ~/.zshrc
