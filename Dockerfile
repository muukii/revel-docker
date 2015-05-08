FROM ubuntu:14.04

MAINTAINER Muukii <muukii.muukii@gmail.com>

ENV HOSTNAME [Revel]

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV DOCKER_CONTAINER YES

# env
RUN sudo apt-get update -y && apt-get dist-upgrade -fy
RUN apt-get install -y \
	build-essential \
	mercurial \
	git \
	wget \
	curl \
	zsh \
	vim \
	tmux

# Generate User
RUN useradd -s /bin/zsh -m muukii
RUN echo 'muukii ALL=(ALL:ALL) NOPASSWD:ALL' | tee /etc/sudoers.d/dev
RUN gpasswd -a muukii root
ENV HOME /home/muukii

# Go
ENV GOPATH /go
ENV GOROOT /usr/local/bin/go
RUN mkdir -p /usr/local/bin
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH:
RUN wget -qO- http://golang.org/dl/go1.3.3.linux-amd64.tar.gz | tar -C /usr/local/bin -xzf -
RUN go get github.com/revel/cmd/revel
RUN chmod 775 -R /go

# Setup MySQL (5.6)
RUN apt-get -y install mysql-server-5.6

# User env
USER muukii
WORKDIR /home/muukii/
RUN git clone https://github.com/muukii0803/dotfiles.git ~/dotfiles
WORKDIR /home/muukii/dotfiles
RUN make symlink
RUN make vim
WORKDIR /home/muukii
RUN mkdir develop
RUN mkdir .ssh

# Define default command.
CMD ["/bin/zsh"]

# CMD service mysql start
