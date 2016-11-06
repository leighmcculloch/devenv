#!/bin/sh
# Go root and working directory paths
export GOROOT=/usr/local/go
export GOPATH_SYSTEM=/usr/local/gopath
export GOPATH_USER=$HOME/go
export GOPATH=$GOPATH_USER:$GOPATH_SYSTEM
export PATH=$PATH:$GOROOT/bin:$GOPATH_USER/bin:$GOPATH_SYSTEM/bin
