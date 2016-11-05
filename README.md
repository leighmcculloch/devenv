# devenv

This repository contains scripts to setup Ubuntu for golang, ruby, swift and rust development, with tmux and vim.

## Usage (Manual)

### System Setup

1. Create a instance with Ubuntu 16.04.
2. `ssh root@[ip-address]`
3. `wget -qO - https://github.com/leighmcculloch/devenv/raw/master/setup.sh | sh`

### Creating Users

1. `adduser-github [github-username]` for everyone who will be pairing.

### User login and pairing using Tmux

1. `ssh -A [github-username]@[ip-address]`
2. You: `tmux -S /tmp/pair new`, and then `setfacl -m user:<username>:rwx /tmp/pair`
3. Them: `tmux -S /tmp/pair attach`

### Deleting Users

1. `deluser --remove-home [username]`

## Usage (Vagrant)

The repository contains a Vagrantfile that will setup a development environment for the single vagrant user. Just run `vagrant up` in the repository directory, and the directory above the repository will be mapped to `/workspace` on the instance.
