FROM google/golang
FROM library/mysql

MAINTAINER Muukii <muukii.muukii@gmail.com>

RUN go get github.com/revel/cmd/revel
