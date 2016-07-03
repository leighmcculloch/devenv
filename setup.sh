TMP=$(mktemp -d)
wget -qO - https://github.com/leighmcculloch/ubuntu-dev/tarball/master | tar xz -C $TMP
cd $TMP/leighmcculloch-ubuntu-dev*
sudo ./setup-sudo.sh
./setup-user.sh
cd - rm -fR $TMP
