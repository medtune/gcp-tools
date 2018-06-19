#!/bin/bash

name=$1

if [ "$name" = "" ]; then
    echo "must provide name"
    exit 1
fi

disksize="$2GB"

if [ "$2" = "GB" ]; then 
  disksize="32GB"
fi

mtype=$3

if [ "$mtype" = "" ]; then 
  disksize="n1-standard-n2"
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
    --image-family $image --image-project $imgproject \
    --maintenance-policy TERMINATE --restart-on-failure 