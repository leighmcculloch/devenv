apt-get -y install \
  libxrender1 \
  libxtst6 \
  libxi6
wget -qO - http://download.jetbrains.com/go/gogland-163.10615.6.tar.gz?mkt_tok=eyJpIjoiWmpCaVlqVmlOR0ZrTWpRNSIsInQiOiJXSStOc3V6ZFN5djlPWVNqWVhIN0lCNkVyYW43a0pBUUxFRVBsYWlaU1dvZE5zZUtWOGJ2T2REeVVKdkx5d1wvSnFOa1g2YzZSYWxTVVpqWGZNWlhyVEVlTVp6TmtQNUJTOG0rRWQ5RVp6NldcLzNabkVhTnhhbUM1aHpSRlpmb2w1In0%3D \
  | tar xz -C /usr/local
ln -s /usr/local/Gogland-163.10615.6/bin/gogland.sh /usr/local/bin/gogland
