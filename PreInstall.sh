#!/usr/bin/env bash

# Packages to install for base system
pacstrap /mnt base base-devel linux linux-firmware

# Packages utils for system works correctly for desktop
pacstrap /mnt grub sudo networkmanager iwd dhcpcd

# Generating File System Table for correctly mount points of devices
genfstab -U -p /mnt >> /mnt/etc/fstab

mv MyI3Config.sh PosInstall.sh /mnt/tmp
arch-chroot /mnt
