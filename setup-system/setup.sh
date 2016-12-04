# Update local package directory
apt-get -y update

# Update to the latest of all packages
if test "${FEATURES#*upgrade}" != "$FEATURES"
then
  apt-get -y dist-upgrade
fi

# Install packages for general use and dev
apt-get -y install \
  build-essential \
  libncurses5-dev \
  mosh \
  curl \
  zsh \
  tmux \
  git \
  make \
  tig \
  jq

# Install vim
ln -s $PWD/deps/vim/bin/vim /usr/local/bin/vim

# Install any custom files
cp -R files/* /

# Install optionals
if test "${FEATURES#*go}" != "$FEATURES"
then
  cd install-go
  ./install-go.sh
  cd -
fi
if test "${FEATURES#*swift}" != "$FEATURES"
then
  cd install-swift
  ./install-swift.sh
  cd -
fi
if test "${FEATURES#*ruby}" != "$FEATURES"
then
  cd install-ruby
  ./install-ruby.sh
  cd -
fi
if test "${FEATURES#*rust}" != "$FEATURES"
then
  cd install-rust
  ./install-rust.sh
  cd -
fi
if test "${FEATURES#*gcloud}" != "$FEATURES"
then
  cd install-gcloud
  ./install-gcloud.sh
  cd -
fi
if test "${FEATURES#*awscli}" != "$FEATURES"
then
  cd install-awscli
  ./install-awscli.sh
  cd -
fi

# Set the script that will be executed when new users are added
cp -R ../setup-user /usr/local/sbin/adduser
