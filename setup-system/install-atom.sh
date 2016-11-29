TMP=$(mktemp -d)
wget -q -O $TMP/atom-amd64.deb https://github.com/atom/atom/releases/download/v1.12.6/atom-amd64.deb
apt-get install -y \
  libxss1 \
  libasound2
dpkg --install $TMP/atom-amd64.deb
apt-get install -yf
dpkg --install $TMP/atom-amd64.deb
rm -fR $TMP
