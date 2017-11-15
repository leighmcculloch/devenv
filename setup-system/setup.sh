# If no features specified, install everything
if [ -z "$FEATURES" ]
then
  FEATURES=upgrade,go,ruby,gcloud,awscli
fi

# Update to the latest of all packages
if test "${FEATURES#*upgrade}" != "$FEATURES"
then
  apt-get -y update
  apt-get -y dist-upgrade
fi

# Install packages for general use and dev
apt-get -y install \
  curl \
  zsh \
  tmux \
  git \
  make \
  tig \
  jq \
  tree \
  unzip

# Install any custom files
cp -R files/* /

# Install neovim
./install-nvim/install-nvim.sh

# Install optionals
if test "${FEATURES#*go}" != "$FEATURES"
then
  cd install-go
  ./install-go.sh
  cd -
fi
if test "${FEATURES#*dotnetcore}" != "$FEATURES"
then
  cd install-dotnetcore
  ./install-dotnetcore.sh
  cd -
fi
if test "${FEATURES#*docker}" != "$FEATURES"
then
  cd install-docker
  ./install-docker.sh
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
if test "${FEATURES#*cfcli}" != "$FEATURES"
then
  cd install-cfcli
  ./install-cfcli.sh
  cd -
fi
if test "${FEATURES#*awscli}" != "$FEATURES"
then
  cd install-awscli
  ./install-awscli.sh
  cd -
fi
if test "${FEATURES#*gogland}" != "$FEATURES"
then
  cd install-jetbrains-gogland
  ./install-jetbrains-gogland.sh
  cd -
fi
if test "${FEATURES#*kotlin}" != "$FEATURES"
then
  cd install-kotlin
  ./install-kotlin.sh
  cd -
fi

# Set the script that will be executed when new users are added
cp -R ../setup-user /usr/local/sbin/adduser
