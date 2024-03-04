#!/bin/sh

NODE_VERSION=${NODE_VERSION:---lts}

# Init
cd ~ && mkdir -p {Desktop,Develop,Documents,Downloads,Pictures,Pictures/Wallpapers,Videos}
sudo sed -i 's/#Color/Color/g' /etc/pacman.conf

# yay
rm -rf ~/Downloads/yay-bin/
git clone https://aur.archlinux.org/yay-bin.git ~/Downloads/yay-bin
cd ~/Downloads/yay-bin/ && makepkg -si
rm -rf yay-bin

# Linux headers
sudo pacman -S --noconfirm linux-headers

# Xorg
sudo pacman -S --noconfirm xorg xorg-server

# Qtile
sudo pacman -S --noconfirm qtile python-psutil python-dbus-next

# Terminal
sudo pacman -S --noconfirm kitty tmux fish starship

# Editor
sudo pacman -S --noconfirm vim neovim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# Fonts
sudo pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-fira-code ttf-firacode-nerd ttf-iosevka-nerd ttf-liberation ttf-font-awesome

# Audio
sudo pacman -S --noconfirm alsa-utils

# Bluetooth
sudo pacman -S --noconfirm bluez bluez-utils blueman

# Utilities
sudo pacman -S --noconfirm picom lxappearance ly rofi jq wget htop maim xclip ripgrep fzf eza bat zoxide feh dunst gzip zip unzip p7zip unrar unarchiver xarchiver neofetch stow
yay -S --noconfirm betterlockscreen ksuperkey
sudo systemctl enable ly # enable ly service

# Themes
sudo pacman -S --noconfirm arc-gtk-theme papirus-icon-theme
yay -S --noconfirm qogir-cursor-theme-git

# File manager
sudo pacman -S --noconfirm thunar thunar-volman thunar-archive-plugin

# Languages programing
# go
sudo pacman -S --noconfirm go

# node
yay -S --noconfirm fnm-bin
fnm install $NODE_VERSION

# Develop tools
# docker
sudo pacman -S --noconfirm docker docker-compose docker-buildx
if [[ ! `getent group docker` ]]; then
  sudo groupadd docker
  sudo gpasswd -a $(USER) docker
fi
