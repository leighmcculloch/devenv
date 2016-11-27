# devenv

This repository contains scripts to setup Ubuntu for golang, ruby, swift and rust development, with tmux and vim.

[![Dply](https://dply.co/dply-135.svg)](https://dply.co/b/EHCJjF00)

After clicking the dply.co button, make sure to change the GitHub username in the cloud-init script box to your own before proceeding, and change the features list to what you want.

## Features

Features that can be specified in the `FEATURES` environment variable:

`go`, `ruby`, `rust`, `swift`, `gcloud`, `awscli`

## Usage

### Setup

1. Create a instance with Ubuntu 16.04 or 16.10. (e.g. DigitalOcean, AWS, etc)
2. Run the setup
  1. With cloud-init
  ```
#!/bin/sh
wget -qO - https://git.io/devenv | FEATURES=go,ruby,rust,swift sh
adduser-github leighmcculloch
adduser leighmcculloch sudo
reboot
```
  2. Manually
    1. `ssh root@[ip-address]`
    2. Execute the script, by using one of these methods:
      * `wget -qO - https://git.io/devenv | FEATURES=go,ruby,rust,swift sh`
      * `curl -sSL https://git.io/devenv | FEATURES=go,ruby,rust,swift sh`
    3. `adduser-github [your-github-username]`
    4. `adduser [your-github-username] sudo`
    5. `reboot`

To only install the languages you need, change the `FEATURES` environment variable.

### Adding Users

Add additional users for anyone you plan to pair or share the instance with:

1. `adduser-github [github-username]`
2. `adduser [github-username] sudo` if sudo access is desired.

### User login and pairing using Tmux

1. `ssh -A [github-username]@[ip-address]`
2. You: `tmux -S /tmp/pair new`, and then `setfacl -m user:<username>:rwx /tmp/pair`
3. Them: `tmux -S /tmp/pair attach`

### Deleting Users

1. `deluser --remove-home [username]`

## Usage (Vagrant)

The repository contains a Vagrantfile that will setup a development environment for the single vagrant user. Just run `vagrant up` in the repository directory, and the directory above the repository will be mapped to `/workspace` on the instance.
