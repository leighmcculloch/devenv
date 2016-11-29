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
  xauth \
  mosh \
  curl \
  zsh \
  tmux \
  git \
  make \
  tig \
  jq

# Install Vim Latest
apt-get -y remove \
  vim \
  vim-runtime \
  vim-tiny \
  vim-common
git clone https://github.com/vim/vim
cd vim
./configure --with-features=huge
make
make install
cd -
rm -fR vim

# Install any custom files
cp -R all/* /

# Install optionals
if test "${FEATURES#*go}" != "$FEATURES"
then
  ./install-go.sh
fi
if test "${FEATURES#*swift}" != "$FEATURES"
then
  ./install-swift.sh
fi
if test "${FEATURES#*ruby}" != "$FEATURES"
then
  ./install-ruby.sh
fi
if test "${FEATURES#*rust}" != "$FEATURES"
then
  ./install-rust.sh
fi
if test "${FEATURES#*gcloud}" != "$FEATURES"
then
  ./install-gcloud.sh
fi
if test "${FEATURES#*awscli}" != "$FEATURES"
then
  ./install-awscli.sh
fi
if test "${FEATURES#*atom}" != "$FEATURES"
then
  ./install-atom.sh
fi

# Set the script that will be executed when new users are added
cp -R ../setup-user /usr/local/sbin/adduser
