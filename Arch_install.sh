#!/usr/bin/env bash

pacstrap /mnt base base-devel linux linux-firmware grub sudo networkmanager iwd dhcpcd
genfstab -U -p /mnt >> /mnt/etc/fstab
mv -f Pictures ScriptPosInstall.sh /mnt
arch-chroot /mnt
