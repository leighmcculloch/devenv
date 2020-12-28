[ -z "$ORIGINAL_PATH" ] && export ORIGINAL_PATH=$PATH

# path reset on new shells
export PATH=$ORIGINAL_PATH

# add rbenv
if [[ -f $LOCAL_BIN/rbenv ]]; then
  export RBENV_ROOT=$(dirname $(dirname $(readlink -n $(which rbenv))))
  eval "$(rbenv init -)"
fi
