FROM debian:bullseye

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
  && apt-get -y autoremove \
  && apt-get -y clean

# locale with utf8
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# add user
ARG USER=leighmcculloch
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
ENV DEVEN="$DEVEL/devenv"
ENV DOTFILES="$DEVEN/dotfiles"
ENV LAZYBIN="$DEVEN/lazybin"
ENV LOCAL="$HOME/local"
ENV LOCAL_BIN="$LOCAL/bin"
ENV PATH="$PATH:$LOCAL_BIN"
RUN mkdir -p "$LOCAL_BIN" \
  && mkdir -p "$DEVEL" \
  && mkdir -p "$LAZYBIN"

# paths for lazybins always installed
ENV PATH=$PATH:$LOCAL_BIN/go/bin
ENV GOBIN=$LOCAL_BIN

# add dotfiles from current version of devenv
COPY ./dotfiles $DOTFILES

# ssh files
RUN mkdir $HOME/.ssh
RUN ln -s $HOME/devel/devenv/dotfiles/ssh/config $HOME/.ssh/config \
  && ln -s $HOME/devel/devenv/dotfiles/ssh/known_hosts $HOME/.ssh/known_hosts

# dotfiles
RUN ln -s $HOME/devel/devenv/dotfiles/zshenv $HOME/.zshenv \
  && ln -s $HOME/devel/devenv/dotfiles/zshrc $HOME/.zshrc \
  && ln -s $HOME/devel/devenv/dotfiles/gitconfig $HOME/.gitconfig \
  && ln -s $HOME/devel/devenv/dotfiles/gitignore_global $HOME/.gitignore_global \
  && ln -s $HOME/devel/devenv/dotfiles/gitmessage $HOME/.gitmessage

# oh-my-zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh $HOME/.oh-my-zsh \
  && mkdir -p $HOME/.oh-my-zsh/custom/themes \
  && curl https://raw.githubusercontent.com/leighmcculloch/zsh-theme-enormous/master/enormous.zsh-theme > $HOME/.oh-my-zsh/custom/themes/enormous.zsh-theme

# tmux dot files
RUN git clone --recursive https://github.com/leighmcculloch/tmux_dotfiles $DEVEL/tmux_dotfiles \
  && cd $DEVEL/tmux_dotfiles \
  && git remote set-url origin github:leighmcculloch/tmux_dotfiles \
  && make install

# shell
SHELL ["/bin/zsh", "--login", "-c"]

# trigger preinstalls
COPY ./lazybin/vim.nox $LAZYBIN
RUN $LAZYBIN/vim.nox --version
COPY ./lazybin/docker $LAZYBIN
RUN $LAZYBIN/docker --version
COPY ./lazybin/go $LAZYBIN
RUN $LAZYBIN/go version
COPY ./lazybin/gopls $LAZYBIN
RUN $LAZYBIN/gopls version
COPY ./lazybin/githubclone $LAZYBIN
RUN $LAZYBIN/githubclone
COPY ./lazybin/rvm $LAZYBIN
RUN $LAZYBIN/rvm list
COPY ./lazybin/node $LAZYBIN
RUN node --version
RUN npm --version
COPY ./lazybin/yarn $LAZYBIN
RUN yarn --version

# add current version of the devenv
ADD . "$DEVEL/devenv"

# working directory
WORKDIR $DEVEL

# tmux
ENTRYPOINT zsh ./devenv/entrypoint.sh
