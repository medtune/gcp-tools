#!/bin/bash

device_id=$1
mnt_dir=$2

if [ "$device_id" = "" ] || [ "$mnt_dir" = "" ]; then
    device_id="sdb"
    mnt_dir="disk2"
    echo "using default device ID: $device_id -- mount DIR: $mnt_dir"
fi

# formatting disk
sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/$device_id

# make mount dir
sudo mkdir -p /mnt/disks/$mnt_dir

# mount device at mount dir
sudo mount -o discard,defaults /dev/$device_id /mnt/disks/$mnt_dir

# chmod writes
sudo chmod a+w /mnt/disks/$mnt_dir

# auto mount at startup
sudo cp /etc/fstab /etc/fstab.backup
sudo blkid /dev/$device_id
echo UUID=`sudo blkid -s UUID -o value /dev/sdb` /mnt/disks/disk-1 ext4 discard,defaults,nofail 0 2 | sudo tee -a /etc/fstab
