FROM ubuntu:14.04

# env vars
ENV HOME /root
ENV GOPATH /root/go
ENV PATH /root/go/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

# GOPATH
RUN mkdir -p /root/go

RUN sudo apt-get update -y && apt-get dist-upgrade -fy
RUN apt-get install -y build-essential mercurial git subversion wget curl
RUN apt-get install zsh

# go 1.3 tarball
RUN wget -qO- http://golang.org/dl/go1.3.linux-amd64.tar.gz | tar -C /usr/local -xzf -

RUN git clone https://github.com/muukii0803/dotfiles ~/dotfiles
RUN bash ~/dotfiles/symlink.sh

ENTRYPOINT [ "/usr/bin/zsh" ]
