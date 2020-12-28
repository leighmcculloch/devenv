# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="enormous"
plugins=(git docker tig golang)
DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh

# aliases
alias renv="eval \$(tmux show-env -s | grep '^SSH_')"

# alias for loading env files
function e() {
  local env_file="$1"
  shift
  env $(cat "$env_file" | xargs) $@
}

# pull pr alias
function gfpr() {
  local prnum="$1"
  local refspec="pull/$prnum/head:pr$prnum"
  if git config remote.upstream.url; then
    git fetch upstream "$refspec"
  else
    git fetch origin "$refspec"
  fi
}

# git aliases
alias ga.="git add ."
alias gde="git diff --exit-code"

# go aliases
for dir in $LOCAL_BIN/go/*;
do
  local v=${dir##*/}
  alias "go$v"="$LOCAL_BIN/go/$v/bin/go"
done

# load fzf
if [[ -a $LOCAL/fzf/shell/key-bindings.zsh ]]; then
  source $LOCAL/fzf/shell/key-bindings.zsh
fi

# make c-p/c-n work exactly like up/down arrows
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

# free up the c-q shortcut for use in vim
stty start undef

# setup homebrew
if [[ -d /home/linuxbrew/.linuxbrew ]]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi
