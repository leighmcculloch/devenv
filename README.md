# scripts-ubuntu

This repository contains scripts to setup Ubuntu for golang, ruby, swift and rust development, with tmux and vim. It also contains a Vagrantfile which uses the scripts to configure itself also.

## Usage

### Ubuntu

Start with Ubuntu 15.10 or 16.04.

#### Setup system

```
wget -qO - https://github.com/leighmcculloch/scripts-ubuntu/raw/master/setup-system.sh | sh
```

#### Create a new user (using Github Username)

If you run this without system setup, it will create a user with ssh authorized_keys that of the github user. If you run this with system setup it will additional run all of the setup-user scripts.

```
wget -qO - https://github.com/leighmcculloch/scripts-ubuntu/raw/master/create-user.sh | sh -s [github-username]
```

#### Delete a user

```
wget -qO - https://github.com/leighmcculloch/scripts-ubuntu/raw/master/delete-user.sh | sh -s [github-username]
```

Note: This assumes that the system has already been setup.

### Vagrant

```
git clone git@github.com:leighmcculloch/scripts-ubuntu.git
cd ubuntu-dev
vagrant up
```

