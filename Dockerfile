FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install \
    procps \
    locales \
    curl \
    zsh \
    tmux \
    git \
    make \
    tig \
    tree \
    jq \
    gcc \
    sudo \
    man \
    gpg \
    pinentry-tty \
    openssh-server \
    openssh-client \
  && apt-get -y autoremove \
  && apt-get -y clean

# locale with utf8
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# create the temp runtime file system for the ssh server
RUN mkdir -p /var/run/sshd

# automatically unlink remote unix sockets when connecting
RUN echo "StreamLocalBindUnlink yes" >> /etc/ssh/sshd_config

# add user
ARG USER
ENV USER=$USER
RUN adduser --home /home/$USER --disabled-password --gecos GECOS $USER \
  && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
  && chmod 0440 /etc/sudoers.d/$USER \
  && groupadd docker \
  && usermod -aG docker $USER \
  && chsh -s /bin/zsh $USER
USER $USER
ENV HOME=/home/$USER

# directory for projects
ENV DEVEL="$HOME/devel"
ENV DEVENV="$DEVEL/.devenv"
ENV DOTFILES="$DEVENV/dotfiles"
ENV LAZYBIN="$DEVENV/lazybin"
ENV SCRIPTS="$DEVENV/scripts"
ENV LOCAL="$HOME/local"
ENV LOCAL_BIN="$LOCAL/bin"
RUN mkdir -p "$LOCAL_BIN" \
  && mkdir -p "$DEVEL" \
  && mkdir -p "$LAZYBIN"

# add dotfiles from current version of devenv
COPY ./dotfiles $DOTFILES

# ssh files
RUN mkdir $HOME/.ssh
RUN ln -s $DOTFILES/ssh/config $HOME/.ssh/config \
  && ln -s $DOTFILES/ssh/known_hosts $HOME/.ssh/known_hosts

# dotfiles
RUN mkdir -m 700 -p $HOME/.gnupg
RUN ln -s $DOTFILES/zshenv $HOME/.zshenv \
  && ln -s $DOTFILES/zshrc $HOME/.zshrc \
  && ln -s $DOTFILES/gitconfig $HOME/.gitconfig \
  && ln -s $DOTFILES/gitignore_global $HOME/.gitignore_global \
  && ln -s $DOTFILES/gitmessage $HOME/.gitmessage \
  && ln -s $DOTFILES/tigrc $HOME/.tigrc \
  && ln -s $DOTFILES/gnupg/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf

# twtxt config
RUN mkdir -p $HOME/.config/twtxt
RUN ln -s $DOTFILES/twtxt/config $HOME/.config/twtxt/config

# oh-my-zsh
ENV ZSH="$HOME/.oh-my-zsh"
RUN git clone https://github.com/robbyrussell/oh-my-zsh $ZSH

# zsh theme
RUN git clone https://github.com/leighmcculloch/zsh-theme-enormous $DEVEL/.zsh-theme-enormous \
  && cd $DEVEL/.zsh-theme-enormous \
  && git remote set-url --add --push origin github:leighmcculloch/zsh-theme-enormous \
  && make install

# tmux dot files
RUN git clone --recursive https://github.com/leighmcculloch/tmux_dotfiles $DEVEL/.tmux_dotfiles \
  && cd $DEVEL/.tmux_dotfiles \
  && git remote set-url --add --push origin github:leighmcculloch/tmux_dotfiles \
  && make install

# envs
ENV PATH="$PATH:$LOCAL_BIN:$SCRIPTS"
# for python
ENV PATH="$PATH:$HOME/.local/bin"
# for yarn
ENV PATH="$PATH:$HOME/.yarn/bin"
# for rust
ENV PATH="$PATH:$HOME/.cargo/bin"
# for rvm
ENV PATH="$PATH:$HOME/.rvm/bin"
# for java
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$LOCAL/apache-maven-3.6.0/bin
# for vim
ENV EDITOR=vim
# for postgres running in docker
ENV PGHOST=localhost
ENV PGUSER=$USER
# for ssh via gpg
ENV SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
# for homebrew to disable analytics
ENV HOMEBREW_NO_ANALYTICS=1
# for vim
# ENV VIM=$LOCAL/share/vim
# for go
ENV PATH="$PATH:$LOCAL_BIN/go/latest/bin"
ENV GOBIN=$LOCAL_BIN
# for lazybin
ENV PATH="$PATH:$LAZYBIN"

# shell
SHELL ["/bin/zsh", "--login", "-c"]

# trigger small tool preinstalls
COPY ./lazybin/clone $LAZYBIN
RUN clone -version
COPY ./lazybin/gas $LAZYBIN
RUN gas -version

# trigger big preinstalls
COPY ./lazybin/go $LAZYBIN
RUN go version
COPY ./lazybin/vim.nox $LAZYBIN
RUN vim.nox --version
COPY ./lazybin/docker $LAZYBIN
RUN docker --version
COPY ./lazybin/gotestsum $LAZYBIN
RUN gotestsum --version
#COPY ./lazybin/rvm $LAZYBIN
#RUN rvm list
#RUN rvm install ruby
#COPY ./lazybin/node $LAZYBIN
#RUN node --version
#RUN npm --version
#COPY ./lazybin/yarn $LAZYBIN
#RUN yarn --version

# add current version of the devenv
ADD . $DEVENV

# working directory
WORKDIR $DEVEL

# tmux
ENTRYPOINT ./.devenv/entrypoint.sh
