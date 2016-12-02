# dot files
cp $(dirname $0)/bash_profile ~/.bash_profile
cp $(dirname $0)/gitconfig ~/.gitconfig
cp $(dirname $0)/gitignore_global ~/.gitignore_global
cp $(dirname $0)/gitmessage ~/.gitmessage
cp $(dirname $0)/zshrc ~/.zshrc
mkdir -p ~/.ssh
cp $(dirname $0)/ssh_config ~/.ssh/config
cp $(dirname $0)/ssh_known_hosts ~/.ssh/known_hosts

# default user and email in global gitconfig
git config --global user.name "$(curl -s https://api.github.com/users/"$username" | jq -M -r '.name')"
git config --global user.email "$( \
  (curl -s https://api.github.com/users/"$username" | jq -M -r -e '.email // empty') \
  || (curl -s https://api.github.com/users/"$username"/events | jq -M -r -e '[.[] | select(.type == "PushEvent") | .payload.commits | .[-1] | .author.email] | .[0] // empty') \
  || printf "$username"@users.noreply.github.com
  )"

# oh-my-zsh
git clone github:robbyrussell/oh-my-zsh ~/.oh-my-zsh

# zsh theme: enormous
mkdir -p ~/.oh-my-zsh/custom/themes
\curl https://raw.githubusercontent.com/leighmcculloch/zsh-theme-enormous/master/enormous.zsh-theme > ~/.oh-my-zsh/custom/themes/enormous.zsh-theme

# tmux dot files
git clone --recursive github:leighmcculloch/tmux_dotfiles ~/.tmux_dotfiles \
  && make -C ~/.tmux_dotfiles install

# vim dot files
git clone github:leighmcculloch/vim_dotfiles ~/.vim_dotfiles \
  && make -C ~/.vim_dotfiles install

# user defined dot files
git clone github:"$USER"/dotfiles ~/.dotfiles || git clone bitbucket:"$USER"/dotfiles ~/.dotfiles \
  && make -C ~/.dotfiles
git clone github:"$USER"/dotfiles-private ~/.dotfiles-private || git clone bitbucket:"$USER"/dotfiles-private ~/.dotfiles-private \
  && make -C ~/.dotfiles-private

# Setup go path if go is installed
if [ -z "$GOPATH" ]; then :; else
  mkdir -p $GOPATH_USER/src/github.com/"$USER"
fi
