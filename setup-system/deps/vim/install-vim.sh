apt-get -y install libncurses5 binutils
tar -xzf vim-*.tar.gz
cd vim
make install
cd -
rm -fR vim
