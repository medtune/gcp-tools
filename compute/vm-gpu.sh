#!/bin/bash

name=$1

if [ "$name" = "" ]; then
    echo "must provide name"
    exit 1
fi

disksize="$2GB"

if [ "$2" = "" ]; then 
  disksize="32GB"
fi

mtype=$3

if [ "$mtype" = "" ]; then 
  disksize="n1-standard-n2"
fi

# nvidia-tesla-k80
accelerator=$4

if [ "$accelerator" = "" ]; then 
  disksize="nvidia-tesla-k80"
fi

# ubuntu-1704-lts
image=$5

if [ "$image" = "" ]; then 
  disksize="ubuntu-1704-lts"
fi

if [ "$imgproject" = ""]; then
  imgproject="ubuntu-os-cloud"
fi


gcloud compute instances create $name \
    --boot-disk-size $disksize \
    --machine-type $mtype --zone europe-west1-b \
    --accelerator type=$accelerator,count=1 \
    --image-family $image --image-project $imgproject \
    --maintenance-policy TERMINATE --restart-on-failure \
    --metadata startup-script='#!/bin/bash
    echo "Checking for CUDA and installing."
    # Check for CUDA and try to install.
    if ! dpkg-query -W cuda-9-0; then
      curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
      dpkg -i ./cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
      apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
      apt-get update
      apt-get install cuda-9-0 -y
    fi'

