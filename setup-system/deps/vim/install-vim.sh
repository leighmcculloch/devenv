apt-get -y remove vim
apt-get -y autoremove
apt-get -y install libncurses5 binutils
tar -xzf vim-*.tar.gz
cd vim
make install
cd -
rm -fR vim
