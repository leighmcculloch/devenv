TMP=$(mktemp -d)
wget -qO - https://github.com/leighmcculloch/devenv/tarball/master | tar xz -C $TMP
cd $TMP/leighmcculloch-devenv*

cd setup-system
./setup.sh
cd -

rm -fR $TMP
