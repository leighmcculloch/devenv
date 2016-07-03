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
./optionals/install-go-sudo.sh
./optionals/install-swift-sudo.sh
