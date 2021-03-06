FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install \
    procps \
    locales \
    zsh \
    gcc \
    sudo \
    man man-db \
    gpg \
    openssh-server \
    openssh-client \
  && (yes | unminimize) \
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
RUN mkdir -p $DEVEL

# working directory
WORKDIR $DEVEL

# add current version of the devenv
ADD . $HOME/devenv

# install dotfiles
RUN cd $HOME/devenv/dotfiles && ./install-remote.sh

# shell
SHELL ["/bin/zsh", "--login", "-c"]

# tmux
ENTRYPOINT $HOME/devenv/entrypoint.sh
