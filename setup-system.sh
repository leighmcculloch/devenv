TMP=$(mktemp -d)
wget -qO - https://github.com/leighmcculloch/scripts-ubuntu/tarball/master | tar xz -C $TMP
cd $TMP/leighmcculloch-scripts-ubuntu*

cd setup-system
./setup.sh
cd -

rm -fR $TMP
