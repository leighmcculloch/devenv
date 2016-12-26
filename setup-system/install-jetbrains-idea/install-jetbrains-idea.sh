apt-get -y install \
  libxrender1 \
  libxtst6 \
  libxi6
wget -qO - https://download.jetbrains.com/idea/ideaIC-2016.3.1.tar.gz \
  | tar xz -C /usr/local
ln -s /usr/local/idea-IC-163.9166.29/bin/idea.sh /usr/local/bin/idea
