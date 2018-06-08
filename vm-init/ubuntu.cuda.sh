#!/bin/bash

if [ -f "$HOME/.ulock" ]; then
    exit 0
fi

apt upgrade -y
apt-get upgrade -y

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

if [ "$ubuntu_version" = "17.04" ]; then 
    if ! dpkg-query -W cuda-9-0; then
        curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1704/x86_64/cuda-repo-ubuntu1704_9.0.176-1_amd64.deb
        dpkg -i ./cuda-repo-ubuntu1704_9.0.176-1_amd64.deb
        apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1704/x86_64/7fa2af80.pub
        apt-get update
        apt-get install cuda-9-0 -y
    fi
elif [ "$ubuntu_version" = "16.04" ]; then
    if ! dpkg-query -W cuda-9-0; then
        curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
        dpkg -i ./cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
        apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
        apt-get update
        apt-get install cuda-9-0 -y
    fi
fi

# Enable persistence mode     
nvidia-smi -pm 1   

add-apt-repository ppa:gophers/archive -y
apt-get update -y

# Path
PATH="$PATH:/usr/lib/go-1.10/bin"
PATH="$PATH:$HOME/bin:$HOME/go/bin"

echo "$?" >> "$HOME/.ulock"