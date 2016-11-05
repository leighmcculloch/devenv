# Update local package directory
apt-get -y update

# Update to the latest of all packages
apt-get -y dist-upgrade

# Install packages for general use and dev
apt-get -y install \
  curl \
  zsh \
  tmux \
  git \
  vim \
  make \
  direnv \
  tig

# Install any custom motds
cp etc/update-motd.d/* /etc/update-motd.d/

# Install any custom profiles
cp etc/profile.d/* /etc/profile.d/

# Install optionals
./install-go.sh
# ./install-swift.sh
# ./install-ruby.sh
# ./install-rust.sh

# Set the script that will be executed when new users are added
cp -R ../setup-user /usr/local/sbin/adduser
cp ./adduser-local.sh /usr/local/sbin/adduser.local
cp ./adduser-github.sh /usr/bin/adduser-github

# Disable root login
passwd -l root
