#!/bin/bash

apt upgrade -y
apt-get upgrade -y

apt-get install -y \
    autoconf \
    automake \
    libtool \
    make \
    g++ \
    htop \
    python3-pip \
    curl 

function makeCUDA() {
    if [ "$ubuntu_version" = "17.04" ]; then 
        if ! dpkg-query -W cuda-9-0; then
            curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1704/x86_64/cuda-repo-ubuntu1704_9.0.176-1_amd64.deb
            dpkg -i ./cuda-repo-ubuntu1704_9.0.176-1_amd64.deb
            sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1704/x86_64/7fa2af80.pub
            sudo apt-get update
            sudo apt-get install cuda-9-0 -y
        fi
    elif [ "$ubuntu_version" = "16.04" ]; then
        if ! dpkg-query -W cuda-9-0; then
            curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
            dpkg -i ./cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
            sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
            sudo apt-get update
            sudo apt-get install cuda-9-0 -y
        fi
    fi
}

makeCUDA

# Enable persistence mode     
nvidia-smi -pm 1   

function makeCUDNN() {
    # download cudnn
    gsutil cp gs://medtune/cudnn/cudnn-9.0-linux-x64-v7.1.tar .

    # install cudnn
    tar -xzvf cudnn-9.0-linux-x64-v7.1.tar
    sudo cp cuda/include/cudnn.h /usr/local/cuda/include
    sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
    sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*

    # clean
    rm cudnn-9.0-linux-x64-v7.1.tar
    rm -rf cudnn
}

makeCUDNN

echo "export CUDA_HOME=/usr/local/cuda" >> $HOME/.profile
echo "export PATH=$PATH:$CUDA_HOME/bin" >> $HOME/.profile
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib64" >> $HOME/.profile
echo "export PATH=$HOME/bin:$HOME/.local/bin:$PATH" >> $HOME/.profile

function installMLRequirements() {
    sudo pip3 install tensorflow
    sudo pip3 install tensorflow-gpu
    sudo pip3 install virtualenv
}

installMLRequirements

echo "DONE"