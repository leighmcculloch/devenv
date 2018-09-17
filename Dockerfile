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
  && apt-get -y autoremove \
  && apt-get -y clean

# locale with utf8
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# vim
RUN apt-get -y install vim-nox

# go - install
RUN curl https://dl.google.com/go/go1.11.linux-amd64.tar.gz | tar xz -C /usr/local
ENV GOPATH="$HOME/go"
ENV PATH="${PATH}:/usr/local/go/bin:$GOPATH/bin"
RUN mkdir -p $GOPATH/src/github.com/leighmcculloch
RUN mkdir -p $GOPATH/src/github.com/lionelbarrow
RUN mkdir -p $GOPATH/src/4d63.com

# home
ENV HOME="/root"

# directory for projects
RUN mkdir $HOME/devel

# ssh files
RUN mkdir $HOME/.ssh
RUN ln -s $HOME/devel/devenv/dotfiles/ssh/config      $HOME/.ssh/config
RUN ln -s $HOME/devel/devenv/dotfiles/ssh/known_hosts $HOME/.ssh/known_hosts

# dotfiles
RUN ln -s $HOME/devel/devenv/dotfiles/zshrc            $HOME/.zshrc
RUN ln -s $HOME/devel/devenv/dotfiles/zprofile         $HOME/.zprofile
RUN ln -s $HOME/devel/devenv/dotfiles/gitconfig        $HOME/.gitconfig
RUN ln -s $HOME/devel/devenv/dotfiles/gitignore_global $HOME/.gitignore_global
RUN ln -s $HOME/devel/devenv/dotfiles/gitmessage       $HOME/.gitmessage

# oh-my-zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh $HOME/.oh-my-zsh
RUN mkdir -p $HOME/.oh-my-zsh/custom/themes \
  && curl https://raw.githubusercontent.com/leighmcculloch/zsh-theme-enormous/master/enormous.zsh-theme > $HOME/.oh-my-zsh/custom/themes/enormous.zsh-theme

# tmux dot files
RUN git clone --recursive https://github.com/leighmcculloch/tmux_dotfiles $HOME/devel/tmux_dotfiles \
  && cd $HOME/devel/tmux_dotfiles \
  && make install \
  && git remote remove origin \
  && git remote add origin github:leighmcculloch/tmux_dotfiles

# vim dot files
RUN git clone https://github.com/leighmcculloch/vim_dotfiles $HOME/devel/vim_dotfiles \
  && cd $HOME/devel/vim_dotfiles \
  && make install \
  && git remote remove origin \
  && git remote add origin github:leighmcculloch/vim_dotfiles

# working directory
WORKDIR $HOME

# shell
ENTRYPOINT ["tmux", "-2", "new"]
