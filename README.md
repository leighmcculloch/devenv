# devenv

This repository contains scripts to setup Ubuntu for golang, ruby, swift and rust development, with tmux and vim.

## Usage TL;DR

1. Create a instance with Ubuntu 16.04.
2. `ssh root@[ip-address]`
3. `wget -qO - https://github.com/leighmcculloch/devenv/raw/master/setup.sh | sh`
4. `adduser-github [github-username]` for everyone who will be pairing.
5. `logout` to exit the ssh session.
6. `ssh -A [github-username]@[ip-address]`
7. `tmux-pair`

## Usage

1. Create a instance with Ubuntu 16.04.

2. Ssh to the instance as root. e.g. `ssh root@[ip-address]`

3. Run the system setup script.

  ```
  wget -qO - https://github.com/leighmcculloch/devenv/raw/master/setup.sh | sh
  ```

  You can alternatively specify the setup script as a `cloud-config` when deploying if you are using Digital Ocean.

  ```yaml
  #cloud-config
  runcmd:
    - wget -qO - https://github.com/leighmcculloch/devenv/raw/master/setup-system.sh | sh
  ```

4. Add users using their github username, which will setup a user, development environment, a pair programming tmux, and pull in their github SSH keys so that they can ssh into the box immediately without a password:

  ```
  $ adduser-github [github-username]
  ```

5. Exit the session. e.g. `logout`

6. You can now ssh into the instance as your github username.

  ```
  ssh [github-username]@[ip-address]
  ```

  To push to Github or pull private repos add `-A` to which will forward your local SSH agent so that the instance can talk to Github using that key.

  ```
  ssh -A [github-username]@[ip-address]
  ```

7. Once you are at a terminal on the instance, run `tmux-pair` and you'll be in a shared tmux session that any other user can join by running the same command.

## Deleting Users

```
$ deluser --remove-home [username]
```
