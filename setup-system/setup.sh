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
  tig \
  jq

# Install any custom files
cp -R all/* /

# Install optionals
if test "${LANGS#*go}" != "$LANGS"
then
  ./install-go.sh
fi
if test "${LANGS#*swift}" != "$LANGS"
then
  ./install-swift.sh
fi
if test "${LANGS#*ruby}" != "$LANGS"
then
  ./install-ruby.sh
fi
if test "${LANGS#*rust}" != "$LANGS"
then
  ./install-rust.sh
fi

# Set the script that will be executed when new users are added
cp -R all/* /
cp -R ../setup-user /usr/local/sbin/adduser

# Disable root login
passwd -l root
