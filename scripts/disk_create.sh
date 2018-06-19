#!/bin/bash

# disk name id in gcp
name=$1

#size in Gb
size=$2

# must be 'pd-standard' or 'pd-ssd'
dtype=$3

# create disk
gcloud compute disks create $name --size $size --type $dtype