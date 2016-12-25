apt-get -y install \
  libxrender1 \
  libxtst6 \
  libxi6
wget -qO - https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.1.2143.tar.gz \
  | tar xz -C /usr/local
ln -s /usr/local/jetbrains-toolbox-1.1.2143/jetbrains-toolbox /usr/local/bin/jetbrains-toolbox
