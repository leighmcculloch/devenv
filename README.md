# scripts-ubuntu-pair-programming-setup

This repository contains scripts to setup Ubuntu for golang, ruby, swift and rust development, with tmux and vim. It also contains a Vagrantfile which uses the scripts to configure itself also.

## Usage

### Ubuntu

Start with Ubuntu 15.10 or 16.04.

```
wget -qO - https://github.com/leighmcculloch/scripts-ubuntu-pair-programming-setup/raw/master/setup.sh | sh
```

### Vagrant

```
git clone git@github.com:leighmcculloch/scripts-ubuntu-pair-programming-setup.git
cd ubuntu-dev
vagrant up
```

