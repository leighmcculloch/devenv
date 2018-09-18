# devenv
[![Docker Automated build](https://img.shields.io/docker/automated/leighmcculloch/devenv.svg)](https://hub.docker.com/r/leighmcculloch/devenv/)

This repository contains my minimal development environment for programming in Go, ruby, and others.

The environment is based on a single Dockerfile.

For my previous development environment built on Vagrant, see the `v1` branch.

## Usage (Docker)

### Build or Pull

```
make build
```

```
docker pull leighmcculloch/devenv
```

### Running

```
make run
```

### Detach from a developement environment

Type `Ctrl-A D`.

### Reattach to a development environment

Rerun the `make` command you ran to create it.

### Create multiple of each type of development environment

Append `ID=n` where `n` is a number.

```
make run
make run ID=2
make run ID=3
```

### Stop all development environments

```
make stop
```

### Delete all development environments

```
make clean
```

## Usage (Docker inside Vagrant)

Create the vagrant virtual machine:

```
vagrant up
```

SSH in to the virtual machine:

```
vagrant ssh
```

To forward your local ssh-agent, make sure it's running, add your keys and append `-A`:

```
eval $(ssh-agent)
ssh-add
vagrant ssh -- -A
```

Use the commands listed under the Usage (Docker) section above to build and run the devenv docker containers.
