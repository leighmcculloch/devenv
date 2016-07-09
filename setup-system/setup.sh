# Additional repositories
add-apt-repository -y ppa:ubuntu-lxc/lxd-stable # For: Golang
apt-get -y update

# Install packages for general use and dev
apt-get -y install \
  curl \
  zsh \
  tmux \
  git \
  vim \
  direnv

# Install optionals
./install-go.sh
# ./install-swift.sh
# ./install-ruby.sh
# ./install-rust.sh

# Set the script that will be executed when new users are added
cp -R ./adduser /usr/local/sbin/
cp ./adduser-local.sh /usr/local/sbin/adduser.local
cp ./adduser-github.sh /usr/bin/adduser-github
