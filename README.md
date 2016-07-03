# ubuntu-dev

This repository contains scripts to setup Ubuntu for golang, ruby, swift and rust development, with tmux and vim. It also contains a Vagrantfile which uses the scripts to configure itself also.

## Usage

### Ubuntu

Start with Ubuntu 15.10 or 16.04.

```
wget -qO - https://github.com/leighmcculloch/ubuntu-dev/raw/master/setup.sh | sh
```

### Vagrant

```
git clone git@github.com:leighmcculloch/ubuntu-dev.git
cd ubuntu-dev
vagrant up
```

