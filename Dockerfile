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

# home
ENV HOME="/root"

# go
RUN curl https://storage.googleapis.com/golang/go1.9.linux-amd64.tar.gz | tar xz -C /usr/local

# go - env vars
ENV GOPATH_TOOLS="/usr/local/gopath"
ENV GOPATH_USER="$HOME/go"
ENV PATH="${PATH}:$GOPATH_USER/bin:$GOPATH_TOOLS/bin:/usr/local/go/bin"

# go - tools
ENV GOPATH=$GOPATH_TOOLS
RUN go get github.com/nsf/gocode
RUN go get github.com/alecthomas/gometalinter
RUN go get golang.org/x/tools/cmd/goimports
RUN go get golang.org/x/tools/cmd/guru
RUN go get golang.org/x/tools/cmd/gorename
RUN go get github.com/golang/lint/golint
RUN go get github.com/rogpeppe/godef
RUN go get github.com/kisielk/errcheck
RUN go get github.com/jstemmer/gotags
RUN go get github.com/klauspost/asmfmt/cmd/asmfmt
RUN go get github.com/fatih/motion
RUN go get github.com/zmb3/gogetdoc
RUN go get github.com/josharian/impl
RUN go get github.com/mailgun/godebug
RUN go get github.com/kardianos/govendor
RUN go get github.com/tools/godep
RUN go get github.com/derekparker/delve/cmd/dlv
RUN go get golang.org/x/review/git-codereview
RUN go get golang.org/x/tools/cmd/go-contrib-init
RUN go get golang.org/x/tools/cmd/present
RUN go get github.com/jmhodges/justrun

# go - working dir
ENV GOPATH=$GOPATH_USER
RUN mkdir -p $GOPATH/src/github.com/leighmcculloch
RUN mkdir -p $GOPATH/src/4d63.com

# ruby / rvm
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby=2.3

# gcloud
RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-182.0.0-linux-x86_64.tar.gz | tar xz -C /usr/local
RUN /usr/local/google-cloud-sdk/install.sh \
  --usage-reporting false \
  --additional-components app-engine-go cloud-datastore-emulator pubsub-emulator \
  --quiet
ENV PATH="${PATH}:/usr/local/google-cloud-sdk/bin"

# ssh files
RUN mkdir                     $HOME/.ssh
ADD dotfiles/ssh/config       $HOME/.ssh/config
ADD dotfiles/ssh/known_hosts  $HOME/.ssh/known_hosts

# dotfiles
ADD dotfiles/zshrc            $HOME/.zshrc
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
