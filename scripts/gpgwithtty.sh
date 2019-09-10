#! /usr/bin/env bash

set -e

gpg-connect-agent updatestartuptty /bye > /dev/null
gpg "$@"
