FROM debian:stretch

RUN apt-get update \
  && apt-get -y install \
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
  && usermod -aG docker $USER
USER $USER
ENV HOME=/home/$USER

# directory for projects
ENV DEVEL="$HOME/devel"
ENV LOCAL="$HOME/local"
ENV LOCAL_BIN="$LOCAL/bin"
ENV PATH="$PATH:$LOCAL_BIN"
RUN mkdir -p "$LOCAL_BIN" \
  && mkdir -p "$DEVEL"

# vim
RUN sudo apt-get -y install libncurses5-dev python3-dev \
  && sudo apt-get -y autoremove \
  && sudo apt-get -y clean \
  && mkdir -p "$DEVEL/vim" \
  && curl -L https://github.com/vim/vim/archive/master.tar.gz | tar xz -C "$DEVEL/vim" --strip-components 1 \
  && cd $DEVEL/vim \
  && ./configure --prefix=$LOCAL \
    --enable-python3interp=yes \
    --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
  && make install

# go - install
RUN curl https://dl.google.com/go/go1.11.linux-amd64.tar.gz | tar xz -C $LOCAL_BIN
ENV GOBIN=$LOCAL_BIN
ENV PATH="$PATH:$LOCAL_BIN/go/bin"

# go - tools (from https://github.com/fatih/vim-go/blob/de896a6/plugin/go.vim#L33-L52)
RUN go get github.com/klauspost/asmfmt/cmd/asmfmt \
  && go get github.com/derekparker/delve/cmd/dlv \
  && go get github.com/kisielk/errcheck \
  && go get github.com/davidrjenni/reftools/cmd/fillstruct \
  && go get github.com/mdempsky/gocode \
  && go get github.com/rogpeppe/godef \
  && go get github.com/zmb3/gogetdoc \
  && go get golang.org/x/tools/cmd/goimports \
  && go get github.com/golang/lint/golint \
  && go get github.com/alecthomas/gometalinter \
  && go get github.com/fatih/gomodifytags \
  && go get golang.org/x/tools/cmd/gorename \
  && go get github.com/jstemmer/gotags \
  && go get golang.org/x/tools/cmd/guru \
  && go get github.com/josharian/impl \
  && go get honnef.co/go/tools/cmd/keyify \
  && go get github.com/fatih/motion \
  && go get github.com/koron/iferr

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

# vim dot files
RUN git clone https://github.com/leighmcculloch/vim_dotfiles $DEVEL/vim_dotfiles \
  && cd $DEVEL/vim_dotfiles \
  && git remote set-url origin github:leighmcculloch/vim_dotfiles \
  && make install

# working directory
WORKDIR $DEVEL

# shell
ENTRYPOINT ["tmux", "-2", "new"]
