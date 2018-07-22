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
    apt-transport-https \
    lsb-release \
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

# azure
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list \
  && apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893 \
  && curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && apt-get update \
  && apt-get install -y azure-cli

# cloudfoundry cli
RUN echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list \
  && curl https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - \
  && apt-get update \
  && apt-get install -y cf-cli

# ngrok
RUN curl -O https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip \
  && unzip ngrok-stable-linux-amd64.zip -d /usr/local/ngrok/ \
  && rm ngrok-stable-linux-amd64.zip
ENV PATH="${PATH}:/usr/local/ngrok"

# home
ENV HOME="/root"

# ssh files
RUN mkdir                          $HOME/.ssh
RUN ln -s $HOME/.ssh/config        $HOME/devel/devenv/dotfiles/ssh/config
RUN ln -s $HOME/.ssh/known_hosts   $HOME/devel/devenv/dotfiles/ssh/known_hosts

# dotfiles
RUN ln -s $HOME/.zshrc             $HOME/devel/devenv/dotfiles/zshrc
RUN ln -s $HOME/.zprofile          $HOME/devel/devenv/dotfiles/zprofile
RUN ln -s $HOME/.gitconfig         $HOME/devel/devenv/dotfiles/gitconfig
RUN ln -s $HOME/.gitignore_global  $HOME/devel/devenv/dotfiles/gitignore_global
RUN ln -s $HOME/.gitmessage        $HOME/devel/devenv/dotfiles/gitmessage

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

# directory for projects
RUN mkdir $HOME/devel

# shell
ENTRYPOINT ["tmux", "-2", "new"]
