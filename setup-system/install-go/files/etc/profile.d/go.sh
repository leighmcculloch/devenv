#!/bin/sh
# Go root and working directory paths
export GOPATH_SYSTEM=/usr/local/gopath
export GOPATH_USER=$HOME/go
export GOPATH=$GOPATH_USER
export PATH=$PATH:$GOROOT/bin:$GOPATH_USER/bin:$GOPATH_SYSTEM/bin
if [ -z "$CDPATH" ]; then
  export CDPATH=.:$HOME
fi
export CDPATH=$CDPATH:$GOPATH/src:$GOPATH/src/github.com/$USER:$GOPATH/src/bitbucket.org/$USER
