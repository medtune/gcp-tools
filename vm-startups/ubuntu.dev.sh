#!/bin/bash

if [ -f "$HOME/.assb.lock" ]; then
    exit 0
fi

apt upgrade -y
apt-get upgrade -y

# Go 1.10
add-apt-repository ppa:gophers/archive -y
apt-get update -y
apt-get install -y \
    autoconf \
    automake \
    libtool \
    make \
    g++ \
    golang-1.10-go \
    htop \
    python3-pip \
    curl

# Set bash profile
echo "PATH=$PATH:$HOME/bin:$HOME/go/bin:/usr/lib/go-1.10/bin" >> $HOME/.profile

# Docker 
apt install docker.io -y
groupadd docker
usermod -aG docker $USER

# Protoc
apt install protobuf-compiler -y
go get -u github.com/golang/protobuf/{proto,protoc-gen-go}
go get -u google.golang.org/grpc

echo "$?" >> "$HOME/.assb.lock"