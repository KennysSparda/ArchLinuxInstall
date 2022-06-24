#!/usr/bin/env bash
# Script criado para agilizar as minhas configuracoes
# pos instalacao do meu sistema preferido:
# ARCH LINUX

function ParallelDownloads() {
	echo "[options]" >> /etc/pacman.conf
  echo "ParallelDownloads = 25" >> /etc/pacman.conf
}

function InstallGrub() {
  pacman -S grub
	echo -e """
	Que forma pretende instalar o grub?
	[ 1 ] BIOS LEGACY
	[ 2 ] UEFI
	"""
	read opc
	if [[ $opc = 1 ]]
       	then
		echo "BIOS LEGACY"
    lsblk
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
	# Habilitando drivers de internet
 	systemctl enable NetworkManager
  
  # Habilitando suporte a wifi
  echo """Vai utilizar driver wifi?
  [ s ] Sim
  [ n ] Nao
  """
  read opc

  if [[ $opc = "s" ]]
  then
    systemctl enable iwd
  fi

  # Habilitando driver para configuracao do DNS da rede
  systemctl enable dhcpcd
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
		pacman -S xf86-video-amdgpu
	else
		echo "Opcao invalida amiguinho tente novamente :3"
		DriverVideo
	fi
}

function Linguagem() {
	echo """
	Linguagem do sistema ?
	[ 1 ] Portugues Brasileiro
	[ 2 ] Ingles
	"""
	read opc
	if [[ $opc = 1 ]]
	then
		echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
	elif [[ $opc = 2 ]]
	then
		echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	else
		echo "Opcao invalida amiguinho tente novamente"
		Linguagem
	fi
}

function Layout() {
	echo """
	Layout do teclado ?
	[ 1 ] BR
	[ 2 ] US
	"""
	read opc
	if [[ $opc = 1 ]]
	then
		echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
	elif [[ $opc = 2 ]]
	then
		echo "KEYMAP=us" >> /etc/vconsole.conf
  else
    echo "Opcao errada amiguinho tente novamente"
		Layout
  fi
	locale-gen

}

function BasicConfigs() {
	Linguagem
	Layout
	ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
	hwclock --systohc
	echo "Insira o nome do PC: "
	read pcname
	echo $pcname >> /etc/hostname
	echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers	
}

function Main() {
  ParallelDownloads
	InstallGrub
	MakeGrubConfig
	SetRootPassWd

	echo -e "insira o nome de usuario: \n=> "
	read username

	AddNewUser
	EnableNet
	DriverVideo

	BasicConfigs
}

Main

