# devenv
[![Docker Automated build](https://img.shields.io/docker/automated/leighmcculloch/devenv.svg)](https://hub.docker.com/r/leighmcculloch/devenv/)

This repository contains my minimal development environment for programming in Go, ruby, and others.

The environment is based on a single Dockerfile.

For my previous development environment built on Vagrant, see the `v1` branch.

The environment assumes you're running a GPG agent locally and that will be forwarded into the environment.

## Usage (Docker)

### Build or Pull

```
make build
```

or

```
make pull
```

### Running

```
make start join
```

After joining an environment for the first time, run `setup` to set git config based on details available via the hosts GPG agent.

### Detach from an instance

Type `Ctrl-A D`.

### Reattach to an instance

Rerun `make join`.

### Create multiple of each type of development environment

Prepend or append `ID=n` where `n` is a number to `make` commands to operate with different instances. The default instance is `0`.

### Stop and teardown an instance

```
make stop rm
```
