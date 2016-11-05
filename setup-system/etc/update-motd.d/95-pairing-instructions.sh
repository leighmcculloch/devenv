#!/bin/sh
printf "Pairing session how-to:\n"
printf "  Create: tmux -S /tmp/pair new\n"
printf "  Share:  setfacl -m user:<username>:rwx /tmp/pair\n"
printf "  Join:   tmux -S /tmp/pair attach\n"
