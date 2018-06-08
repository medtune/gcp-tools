#!/bin/bash

# Ubuntu 16.04
# 1*CPU 4Go RAM
# Disk 32Go
gcloud compute instances create gpu-instance-1 \
    --boot-disk-size 32GB \
    --machine-type n1-standard-1 --zone europe-west1-b \
    --image-family ubuntu-1604-lts --image-project ubuntu-os-cloud \
    --maintenance-policy TERMINATE --restart-on-failure \
