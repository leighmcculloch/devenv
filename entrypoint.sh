#! /usr/bin/env zsh

# Allow using the docker socket without root.
sudo chgrp docker /var/run/docker.sock

# Start-up the SSH-Agent and GPG-Agent so they can be used across all
# tmux panes/windows.
eval $(ssh-agent -s)
eval $(gpg-agent --daemon)

# Start TMUX for all terminal access.
tmux -2 new
