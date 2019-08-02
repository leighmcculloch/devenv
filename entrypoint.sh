# Allow using the docker socket without root.
sudo chgrp docker /var/run/docker.sock

# Start-up the SSH-Agent so it can be used across all tmux panes/windows.
eval $(ssh-agent -s)

# Start TMUX for all terminal access.
tmux -2 new
