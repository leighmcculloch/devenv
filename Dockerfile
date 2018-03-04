FROM debian:stretch

RUN apt-get update \
  && apt-get -y install \
    locales \
    curl \
    zsh \
    tmux \
    git \
    make \
    gnupg2 \
    tig \
    tree \
    jq \
    python python-pip \
    sassc \
    protobuf-compiler \
  && apt-get -y autoremove \
  && apt-get -y clean

# locale with utf8
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8   

# vim
RUN apt-get -y install vim-nox

# gcloud (requires python)
RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-182.0.0-linux-x86_64.tar.gz | tar xz -C /usr/local
RUN /usr/local/google-cloud-sdk/install.sh \
  --usage-reporting false \
  --additional-components app-engine-go cloud-datastore-emulator pubsub-emulator \
  --quiet
ENV PATH="${PATH}:/usr/local/google-cloud-sdk/bin"

# aws (requires python, python-pip)
RUN pip install awscli --upgrade --user

# ngrok
RUN curl -O https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip \
  && unzip ngrok-stable-linux-amd64.zip -d /usr/local/ngrok/ \
  && rm ngrok-stable-linux-amd64.zip
ENV PATH="${PATH}:/usr/local/ngrok"

# hub
RUN curl -LO https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz \
  && mkdir -p /usr/local/hub \
  && tar -xvzf hub-linux-amd64-2.2.9.tgz -C /usr/local/hub/ \
  && rm hub-linux-amd64-2.2.9.tgz
ENV PATH="${PATH}:/usr/local/hub/hub-linux-amd64-2.2.9/bin"

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
RUN mkdir -p $HOME/.oh-my-zsh/custom/themes \
  && curl https://raw.githubusercontent.com/leighmcculloch/zsh-theme-enormous/master/enormous.zsh-theme > $HOME/.oh-my-zsh/custom/themes/enormous.zsh-theme

# tmux dot files
RUN git clone --recursive https://github.com/leighmcculloch/tmux_dotfiles $HOME/.tmux_dotfiles \
  && cd $HOME/.tmux_dotfiles \
  && make install \
  && git remote remove origin \
  && git remote add origin github:leighmcculloch/tmux_dotfiles

# vim dot files
RUN git clone https://github.com/leighmcculloch/vim_dotfiles $HOME/.vim_dotfiles \
  && cd $HOME/.vim_dotfiles \
  && make install \
  && git remote remove origin \
  && git remote add origin github:leighmcculloch/vim_dotfiles

# working directory
WORKDIR $HOME

# shell
ENTRYPOINT ["tmux", "-2", "new"]
