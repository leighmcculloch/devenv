FROM ubuntu:17.10

RUN apt-get update
RUN apt-get -y install \
  curl \
  zsh \
  tmux \
  git \
  make \
  tig \
  jq \
  tree \
  software-properties-common

# neovim
RUN add-apt-repository -y ppa:neovim-ppa/stable
RUN apt-get update
RUN apt-get -y install neovim

# gcloud
RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-182.0.0-linux-x86_64.tar.gz | tar xz -C /usr/local
RUN /usr/local/google-cloud-sdk/install.sh \
  --usage-reporting false \
  --additional-components app-engine-go cloud-datastore-emulator pubsub-emulator \
  --quiet
ENV PATH="${PATH}:/usr/local/google-cloud-sdk/bin"

# home
ENV HOME="/root"

# ssh files
RUN mkdir                     $HOME/.ssh
ADD dotfiles/ssh/config       $HOME/.ssh/config
ADD dotfiles/ssh/known_hosts  $HOME/.ssh/known_hosts

# dotfiles
ADD dotfiles/zshrc            $HOME/.zshrc
ADD dotfiles/zprofile         $HOME/.zprofile
ADD dotfiles/gitconfig        $HOME/.gitconfig
ADD dotfiles/gitignore_global $HOME/.gitignore_global
ADD dotfiles/gitmessage       $HOME/.gitmessage

# oh-my-zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh $HOME/.oh-my-zsh
RUN mkdir -p $HOME/.oh-my-zsh/custom/themes
RUN curl https://raw.githubusercontent.com/leighmcculloch/zsh-theme-enormous/master/enormous.zsh-theme \
  > $HOME/.oh-my-zsh/custom/themes/enormous.zsh-theme

# tmux dot files
RUN git clone --recursive https://github.com/leighmcculloch/tmux_dotfiles $HOME/.tmux_dotfiles \
  && make -C $HOME/.tmux_dotfiles install

# neovim dot files
RUN git clone https://github.com/leighmcculloch/neovim_dotfiles $HOME/.neovim_dotfiles \
  && make -C $HOME/.neovim_dotfiles install

# working directory
WORKDIR $HOME

# shell
CMD ["tmux", "-2", "new"]
