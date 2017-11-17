apt-get -y install \
  libxrender1 \
  libxtst6 \
  libxi6
wget -qO - https://download.jetbrains.com/go/goland-173.3727.24.tar.gz \
  | tar xz -C /usr/local
ln -s /usr/local/GoLand-173.3727.24/bin/goland.sh /usr/local/bin/goland
