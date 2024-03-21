NODE_VERSION ?= --lts

folder:
	cd ~ && mkdir -p {Desktop,Develop,Documents,Downloads,Pictures,Pictures/Wallpapers,Videos}
	sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
	sudo sed -i 's/#ParallelDownload/ParallelDownload/g' /etc/pacman.conf

yay:
ifeq ($(shell yay --version 2>/dev/null),)
	rm -rf ~/Downloads/yay-bin/
	git clone https://aur.archlinux.org/yay-bin.git ~/Downloads/yay-bin
	cd ~/Downloads/yay-bin/ && makepkg -si
	rm -rf yay-bin
endif

install: folder yay
	# Linux headers
	sudo pacman -S --noconfirm linux-headers

	# Xorg
	sudo pacman -S --noconfirm xorg xorg-server xcolor

	# Qtile
	sudo pacman -S --noconfirm qtile python-psutil python-dbus-next

	# Terminal
	sudo pacman -S --noconfirm kitty tmux fish starship xclip ripgrep fzf eza bat zoxide feh jq wget htop lazygit fzf

	# Fonts
	sudo pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-fira-code ttf-firacode-nerd ttf-iosevka-nerd ttf-liberation ttf-font-awesome

	# Audio
	sudo pacman -S --noconfirm alsa-utils

	# Bluetooth
	sudo pacman -S --noconfirm bluez bluez-utils blueman

	# Utilities
	sudo pacman -S --noconfirm picom lxappearance ly rofi maim dunst gzip zip unzip p7zip unrar unarchiver xarchiver neofetch stow openssh inetutils
	yay -S --noconfirm betterlockscreen ksuperkey
	sudo systemctl enable ly # enable ly service

	# Themes
	sudo pacman -S --noconfirm arc-gtk-theme papirus-icon-theme
	yay -S --noconfirm qogir-cursor-theme-git

	# File manager
	sudo pacman -S --noconfirm thunar thunar-volman thunar-archive-plugin
sshkey:
	ssh-keygen -t rsa -C "$(USER)"
	eval "$$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa
	bat ~/.ssh/id_rsa.pub
	xclip -sel clip < ~/.ssh/id_rsa.pub
docker:
	sudo pacman -S --noconfirm docker docker-compose docker-buildx
	sudo usermod -aG docker $(USER)
go:
	sudo pacman -S --noconfirm go
node:
	yay -S --noconfirm fnm-bin
	fnm install $(NODE_VERSION)
virtualbox:
	sudo pacman -S --noconfirm virtualbox virtualbox-guest-utils
	sudo modprobe vboxdrv
colorscript:
	yay -S --noconfirm shell-color-scripts
	colorscript -b hex
vim:
	rm -rf ~/.config/nvim
	rm -rf ~/.local/share/nvim
	sudo pacman -S --noconfirm vim neovim
