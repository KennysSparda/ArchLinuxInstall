#!/usr/bin/env bash

pacstrap /mnt base base-devel linux linux-firmware grub sudo networkmanager
genfstab -U -p /mnt /mnt/etc/fstab
arch-chroot /mnt
