# devenv

This repository contains scripts to setup Ubuntu for golang, ruby, swift and rust development, with tmux and vim.

## Try it out

[![Dply](https://dply.co/b.svg)](https://dply.co/b/CnKOnaNm)

After clicking the button, make sure to change the GitHub username in the cloud-init script box to your own before proceeding, and change the features list to what you want.

## Features

Features that can be specified in the `FEATURES` environment variable:
  * `go`
  * `ruby`
  * `rust`
  * `swift`
  * `gcloud`
  * `awscli`

## Usage

### System Setup

#### With cloud-init

```
#!/bin/sh
wget -qO - https://git.io/devenv | FEATURES=go,ruby,rust,swift sh
adduser-github leighmcculloch
reboot
```

#### Without cloud-init

1. Create a instance with Ubuntu 16.04 or 16.10. (e.g. DigitalOcean, AWS, etc)
2. `ssh root@[ip-address]`
3. Execute the script, by using one of these methods:
  * `wget -qO - https://git.io/devenv | FEATURES=go,ruby,rust,swift sh`
  * `curl -sSL https://git.io/devenv | FEATURES=go,ruby,rust,swift sh`

To only install the languages you need, change the `FEATURES` environment variable in step three.

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
