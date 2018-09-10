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
    ruby ruby-dev \
    sassc \
    protobuf-compiler \
    apt-transport-https \
    lsb-release \
    software-properties-common \
  && apt-get -y autoremove \
  && apt-get -y clean

# locale with utf8
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8   

# docker client
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/debian \
     $(lsb_release -cs) \
     stable" \
  && apt-get update \
  && apt-get -y install docker-ce

# nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs \
  && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update \
  && apt-get install -y yarn

# vim
RUN apt-get -y install vim-nox

# gcloud (requires python)
RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-182.0.0-linux-x86_64.tar.gz | tar xz -C /usr/local
RUN /usr/local/google-cloud-sdk/install.sh \
  --usage-reporting false \
  --additional-components app-engine-go cloud-datastore-emulator pubsub-emulator \
  --quiet
ENV PATH="${PATH}:/usr/local/google-cloud-sdk/bin"

# firebase (requires nodejs, yarn)
RUN yarn global add firebase-tools

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

# go - install
RUN curl https://dl.google.com/go/go1.11.linux-amd64.tar.gz | tar xz -C /usr/local
ENV GOPATH="$HOME/go"
ENV PATH="${PATH}:/usr/local/go/bin:$GOPATH/bin"
RUN go get github.com/mdempsky/gocode \
  && go get github.com/golang/dep/cmd/dep \
  && go get github.com/alecthomas/gometalinter \
  && go get golang.org/x/tools/cmd/goimports \
  && go get golang.org/x/tools/cmd/guru \
  && go get golang.org/x/tools/cmd/gorename \
  && go get github.com/golang/lint/golint \
  && go get github.com/rogpeppe/godef \
  && go get github.com/kisielk/errcheck \
  && go get github.com/jstemmer/gotags \
  && go get github.com/klauspost/asmfmt/cmd/asmfmt \
  && go get github.com/fatih/motion \
  && go get github.com/zmb3/gogetdoc \
  && go get github.com/josharian/impl \
  && go get github.com/mailgun/godebug \
  && go get github.com/derekparker/delve/cmd/dlv \
  && go get golang.org/x/review/git-codereview \
  && go get golang.org/x/tools/cmd/go-contrib-init \
  && go get golang.org/x/tools/cmd/present \
  && go get github.com/jmhodges/justrun \
  && go get github.com/golang/protobuf/protoc-gen-go
RUN mkdir -p $GOPATH/src/github.com/leighmcculloch
RUN mkdir -p $GOPATH/src/github.com/lionelbarrow
RUN mkdir -p $GOPATH/src/4d63.com

# ruby
RUN gem install bundler

# vscode
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg \
  && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' \
  && apt-get update \
  && apt-get install -y code libxss1 libasound2

# home
ENV HOME="/root"

# vscode extensions
RUN mkdir -p $HOME/.vscode
RUN code --user-data-dir="$HOME/.vscode" --install-extension="ms-vscode.go" \
  && code --user-data-dir="$HOME/.vscode" --install-extension="rebornix.ruby" \
  && code --user-data-dir="$HOME/.vscode" --install-extension="peterjausovec.vscode-docker"
RUN go get github.com/ramya-rao-a/go-outline \
  && go get github.com/acroca/go-symbols \
  && go get golang.org/x/tools/cmd/godoc \
  && go get github.com/fatih/gomodifytags \
  && go get sourcegraph.com/sqs/goreturns \
  && go get github.com/cweill/gotests/... \
  && go get github.com/haya14busa/goplay/cmd/goplay \
  && go get github.com/uudashr/gopkgs/cmd/gopkgs \
  && go get github.com/davidrjenni/reftools/cmd/fillstruct

# old app engine go sdk (requires python)
RUN curl -O https://storage.googleapis.com/appengine-sdks/featured/go_appengine_sdk_linux_amd64-1.9.67.zip \
  && unzip go_appengine_sdk_linux_amd64-1.9.67.zip -d /usr/local/google-appengine-sdk-go/ \
  && rm go_appengine_sdk_linux_amd64-1.9.67.zip
ENV PATH="${PATH}:/usr/local/google-appengine-sdk-go/go_appengine"

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
