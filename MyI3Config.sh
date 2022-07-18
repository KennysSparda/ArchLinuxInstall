#!/usr/bin/env bash

###    SCRIPT WITH MY I3 PERSONALIZED    ###


function Downloads() {
  # Gerenciador de janelas i3 e Dmenu para pesquisas
  pacman -S xorg-server xorg-xinit i3-gaps i3status dmenu
  # Fontes
  pacman -S ttf-nerd-fonts-symbols-mono ttf-inconsolata terminus-font
  # Ferramentas e Programas uteis
  pacman -S git konsole pavucontrol nitrogen dolphin

  # Clonando repositorio com minhas configuracoes do i3wm
  git clone https://github.com/KennysSparda/dotfiles.git
  
  # Link Para clone da ferramenta 'yay' para instalacao de pacotes da AUR *Opcional* #
  #git clone https://aur.archlinux.org/yay.git
}

function Installs() {

  ### Creating diretories ###
  mkdir ~/.config/
  mkdir ~/.config/i3

  ### Install the configurations ###
  mv dotfiles/.config/i3/config ~/.config/i3/config
  mv -f dotfiles/.config/automountp/ ~/.config/
  mv -f dotfiles/.config/wallpaper ~/.config
  mv dotfiles/.i3status.conf ~/.i3status.conf
  mv dotfiles/.vimrc ~/.vimrc
  mv dotfiles/.zshrc ~/.zshrc

  ### Creating the file to start Xorg session ###
  touch ~/.xinitrc
  echo "exec i3" > ~/.xinitrc
}

function Clear() {
  rm -rf dotfiles
}


######    MAIN FUNCTION    ######
function main() {
  Downloads
  Installs
  Clear
}

###  Call main function
main

