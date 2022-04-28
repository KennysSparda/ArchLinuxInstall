#!/usr/bin/env bash
# Script criado para agilizar as minhas configuracoes
# pos instalacao do meu sistema preferido:
# ARCH LINUX

function InstallGrub() {
	echo -e """
	Que forma pretende instalar o grub?
	[ 1 ] BIOS LEGACY
	[ 2 ] UEFI
	"""
	read opc
	if [[ $opc = 1 ]]
       	then
		echo "BIOS LEGACY"
		echo "Insira a unidade que sera instalado o sistema: /dev/?"
		read device
		grub-install --target=i386-pc --recheck /dev/$device
	elif [[ $opc = 2 ]]
	then
		echo " UEFI"
		pacman -S efibootmgr os-prober
		grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Killzone --recheck
	else
		echo "Opcao invalida amiguinho tente novamente :3"
		InstallGrub
	fi
}

function MakeGrubConfig() {
	touch /usr/bin/update-grub
	echo "grub-mkconfig -o /boot/grub/grub.cfg" > /usr/bin/update-grub
	chmod +x /usr/bin/update-grub
	update-grub
}

function SetRootPassWd() {
	# Definindo senha do usuario root
	echo "insira a nova senha de root"
	passwd
}

function AddNewUser() {
	# Funcao para adicionar novo usuario
	useradd -m -g users -G wheel,storage,power -s /bin/bash $username
	# Definindo nova senha para o novo usuario
	echo "insira a nova senha para o usuario $username"
	passwd $username
	echo "Deseja inserir novos usuarios? s / n"
	read opc
	if [[ $opc = "s" ]]
	then
		AddNewUser
	elif [[ $opc = "n" ]]
	then
		return
	else
		echo "Opcao invalida amiguinho tente novamente :3"
	fi
}

function EnableNet() {
	# Instalando drivers de internet
	systemctl enable NetworkManager
}

function DriverVideo() {
	echo """
	Qual a sua placa de video ?
	[ 1 ] INTEL
        [ 2 ] NVIDIA
	[ 3 ] AMD	
	"""
	read opc
	if [[ $opc = 1 ]]
	then
		sudo pacman -S xf86-video-intel
	elif [[ $opc = 2 ]]
	then
		sudo pacman -S nvidia nvidia-settings
	elif [[ $opc = 3 ]] 
	then
		sudo pacman -S xf86-video-amdgpu
	else
		echo "Opcao invalida amiguinho tente novamente :3"
		DriverVideo
	fi
}

function BasicConfigs() {
	ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
	hwclock --systohc
	
	echo """
	Layout do teclado ?
	[ 1 ] BR
	[ 2 ] US
	"""
	read opc
	if [[ $opc = 1 ]]
	then
		echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
		echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
	elif [[ $opc = 2 ]]
	then
		echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
		echo "KEYMAP=us" >> /etc/vconsole.conf
	fi
	locale-gen
	echo "Insira o nome do PC: "
	read pcname
	echo $pcname >> /etc/hostname
	echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers	
}

function MyCustomWM() {
	pacman -S git xorg-server xorg-xinit nitrogen i3-gaps i3status dmenu ttf-nerd-fonts-symbols-mono ttf-inconsolata konsole
	cd /home/$username
	git clone https://aur.archlinux.org/yay.git
	git clone https://github.com/KennysSparda/dotfiles	
	mkdir /home/$username/.config
	mkdir /home/$username/.config/i3
	mv dotfiles/.vimrc /home/$username/.vimrc
	mv dotfiles/i3status.conf /home/$username/.i3status.conf
	mv dotfiles/.config/i3/config /home/$username/.config/i3/config
	touch /home/$username/.xinitrc
	echo "exec i3" > /home/$username/.xinitrc
}

function Main() {
	#InstallGrub
	#MakeGrubConfig
	#SetRootPassWd

	echo "insira o nome de usuario: "
	read username

	#AddNewUser
	#EnableNet
	#DriverVideo
	#BasicConfigs
	MyCustomWM
}

Main
