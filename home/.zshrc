# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="tiny"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# direnv
eval "$(direnv hook zsh)"

# exports
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# go path
mkdir -p $HOME/go

# autostart pairing
if [[ ! $TERM =~ screen ]]; then
  tmux new-session -s pair || tmux attach-session -t pair
fi
