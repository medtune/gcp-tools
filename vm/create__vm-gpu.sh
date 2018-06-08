#!/bin/bash

# Ubuntu 16.04
# 2*CPU 7.5Go RAM
# 1*Nvidia k80
# Disk 64Go
gcloud compute instances create gpu-instance-1 \
    --boot-disk-size 64GB \
    --machine-type n1-standard-2 --zone europe-west1-b \
    --accelerator type=nvidia-tesla-k80,count=1 \
    --image-family ubuntu-1604-lts --image-project ubuntu-os-cloud \
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

