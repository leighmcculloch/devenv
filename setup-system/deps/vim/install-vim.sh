apt-get -y remove vim
apt-get -y autoremove
apt-get -y build-dep vim
tar -xzf vim-*.tar.gz
cd vim
make install
cd -
rm -fR vim
