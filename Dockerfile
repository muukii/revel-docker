FROM ubuntu:14.04

MAINTAINER Muukii

ENV HOSTNAME [Revel]

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# env
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
	tmux

# User
RUN useradd -s /bin/zsh -m muukii
RUN echo 'muukii ALL=(ALL:ALL) NOPASSWD:ALL' | tee /etc/sudoers.d/dev
USER muukii
WORKDIR /home/muukii
ENV HOME /home/muukii

# User vars
ENV GOPATH /go
ENV GOROOT /usr/local/bin/go
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games


# GOPATH
RUN mkdir -p /usr/local/bin

# go 1.3 tarball
RUN wget -qO- http://golang.org/dl/go1.3.3.linux-amd64.tar.gz | tar -C /usr/local/bin -xzf -

RUN go get github.com/revel/cmd/revel

RUN git clone https://github.com/muukii0803/dotfiles.git ~/dotfiles
RUN bash ~/dotfiles/symlink.sh
RUN mkdir develop
RUN mkdir .ssh

# Define default command.
CMD ["/bin/zsh"]
