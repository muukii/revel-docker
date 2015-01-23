FROM ubuntu:14.04

MAINTAINER Muukii

ENV HOSTNAME [Revel]

ENV LC_MESSAGES=ja_JP.UTF-8
ENV LC_IDENTIFICATION=ja_JP.UTF-8
ENV LC_COLLATE=ja_JP.UTF-8
ENV LANG=ja_JP.UTF-8
ENV LC_MEASUREMENT=ja_JP.UTF-8
ENV LC_CTYPE=ja_JP.UTF-8
ENV LC_TIME=ja_JP.UTF-8
ENV LC_NAME=ja_JP.UTF-8

# env vars
ENV GOPATH /root/go
ENV PATH /root/go/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

# GOPATH
RUN mkdir -p /root/go

RUN sudo apt-get update -y && apt-get dist-upgrade -fy
RUN apt-get install -y \
	build-essential \
	mercurial \
	git \
	subversion \
	wget \
	curl \
	zsh \
	vim \
	tmux \

# go 1.3 tarball
RUN wget -qO- http://golang.org/dl/go1.3.linux-amd64.tar.gz | tar -C /usr/local -xzf -

RUN useradd -s /bin/zsh -m muukii
RUN echo 'muukii ALL=(ALL:ALL) NOPASSWD:ALL' | tee /etc/sudoers.d/dev
USER muukii
WORKDIR /home/muukii
ENV HOME /home/muukii

RUN git clone https://github.com/muukii0803/dotfiles.git ~/dotfiles
RUN bash ~/dotfiles/symlink.sh

#ENTRYPOINT [ "/usr/bin/zsh" ]
