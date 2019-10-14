#! /usr/bin/env zsh

# Allow using the docker socket without root.
sudo chgrp docker /var/run/docker.sock

# Start TMUX for all terminal access.
function keep_tmux_up() {
  while true
  do
    echo Starting TMUX session.
    tmux -2 new -d

    # Wait while session is alive.
    while tmux has-session -t 0
    do
      echo TMUX session is up. Available to join.
      sleep 1
    done
    echo TMUX session is down.
  done
}
keep_tmux_up &

sudo /usr/sbin/sshd -D
