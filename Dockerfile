FROM debian:buster

RUN apt-get update \
  && apt-get -y install \
    procps \
    locales \
    curl \
    zsh \
    tmux \
    git \
    mercurial \
    make \
    tig \
    tree \
    jq \
    gcc \
    sudo \
    man \
    gpg \
    pinentry-tty \
  && apt-get -y autoremove \
  && apt-get -y clean

# locale with utf8
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

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
ENV LOCAL="$HOME/local"
ENV LOCAL_BIN="$LOCAL/bin"
ENV PATH="$PATH:$LOCAL_BIN"
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
RUN ln -s $DOTFILES/zshenv $HOME/.zshenv \
  && ln -s $DOTFILES/zshrc $HOME/.zshrc \
  && ln -s $DOTFILES/gitconfig $HOME/.gitconfig \
  && ln -s $DOTFILES/gitignore_global $HOME/.gitignore_global \
  && ln -s $DOTFILES/gitmessage $HOME/.gitmessage \
  && ln -s $DOTFILES/tigrc $HOME/.tigrc

# oh-my-zsh
ENV ZSH="$HOME/.oh-my-zsh"
RUN git clone https://github.com/robbyrussell/oh-my-zsh $ZSH

# zsh theme
RUN git clone https://github.com/leighmcculloch/zsh-theme-enormous $DEVEL/.zsh-theme-enormous \
  && cd $DEVEL/.zsh-theme-enormous \
  && git remote set-url origin github:leighmcculloch/zsh-theme-enormous \
  && make install

# tmux dot files
RUN git clone --recursive https://github.com/leighmcculloch/tmux_dotfiles $DEVEL/.tmux_dotfiles \
  && cd $DEVEL/.tmux_dotfiles \
  && git remote set-url origin github:leighmcculloch/tmux_dotfiles \
  && make install

# shell
SHELL ["/bin/zsh", "--login", "-c"]

# trigger preinstalls
COPY ./lazybin/go $LAZYBIN
RUN go version
COPY ./lazybin/vim $LAZYBIN
RUN vim --version
COPY ./lazybin/docker $LAZYBIN
RUN docker --version
COPY ./lazybin/githubclone $LAZYBIN
RUN githubclone
#COPY ./lazybin/rvm $LAZYBIN
#RUN rvm list
#COPY ./lazybin/node $LAZYBIN
#RUN node --version
#RUN npm --version
#COPY ./lazybin/yarn $LAZYBIN
#RUN yarn --version
COPY ./lazybin/gitallstatus $LAZYBIN
RUN gitallstatus --help

# add current version of the devenv
ADD . $DEVENV

# working directory
WORKDIR $DEVEL

# tmux
ENTRYPOINT ./.devenv/entrypoint.sh
