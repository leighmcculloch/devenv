#! /usr/bin/env zsh

# Allow using the docker socket without root.
sudo chgrp docker /var/run/docker.sock

# Start-up the GPG-Agent for managing SSH and GPG so they can be used across
# all tmux panes/windows.
eval $(gpg-agent --daemon --enable-ssh-support --disable-scdaemon)

# Start TMUX for all terminal access.
tmux -2 new
