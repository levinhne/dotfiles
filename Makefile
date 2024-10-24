# Makefile to manage system configuration and installation

NODE_VERSION ?= --lts
USER ?= $(shell whoami)  # Default to the current user

.PHONY: install folder yay xorg qtile terminal utilities filemanager dmenu ibus-bamboo themes fonts sshkey devops go node virtualbox docker-compose update sudoers check-usb find-iso iso-to-usb

# Define common commands
PACMAN_CMD = sudo pacman -S --noconfirm
YAY_CMD = yay -S --noconfirm
GIT_CMD = git clone
RM_CMD = rm -rf

# Default target
install: folder yay xorg qtile terminal utilities filemanager dmenu ibus-bamboo themes fonts sshkey devops go node virtualbox docker-compose sudoers

folder:
	cd ~ && mkdir -p {Desktop,Develop,Documents,Downloads,Pictures,Pictures/Wallpapers,Videos}
	sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
	sudo sed -i 's/#ParallelDownload/ParallelDownload/g' /etc/pacman.conf

yay:
	if ! command -v yay > /dev/null; then \
		$(RM_CMD) ~/Downloads/yay-bin/; \
		$(GIT_CMD) https://aur.archlinux.org/yay-bin.git ~/Downloads/yay-bin; \
		cd ~/Downloads/yay-bin/ && makepkg -si; \
		$(RM_CMD) yay-bin; \
	fi

xorg:
	$(PACMAN_CMD) xorg xorg-server xcolor

qtile:
	$(PACMAN_CMD) qtile python-psutil python-dbus-next

terminal:
	$(RM_CMD) ~/.config/nvim ~/.local/share/nvim
	$(PACMAN_CMD) vi vim neovim kitty tmux fish fisher starship xclip ripgrep fzf eza bat zoxide feh jq wget htop lazygit

utilities: 
	$(PACMAN_CMD) picom lxappearance ly maim dunst gzip zip unzip p7zip unrar unarchiver xarchiver neofetch stow openssh inetutils alsa-utils xdg-utils 
	$(PACMAN_CMD) bluez bluez-utils blueman
	$(YAY_CMD) ksuperkey redshift
	sudo systemctl enable ly 
	sudo sed -i 's/#AutoEnable=true/AutoEnable=true/g' /etc/bluetooth/main.conf
	sudo systemctl enable bluetooth

lockscreen:
	$(RM_CMD) ~/Downloads/i3lock-color
	$(GIT_CMD) https://github.com/Raymo111/i3lock-color.git ~/Downloads/i3lock-color
	cd ~/Downloads/i3lock-color && ./install-i3lock-color.sh
	wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | bash -s user

filemanager:
	$(PACMAN_CMD) qt5ct pcmanfm ranger

dmenu:
	$(RM_CMD) ~/Downloads/dmenu-distrotube
	$(GIT_CMD) https://gitlab.com/dwt1/dmenu-distrotube.git ~/Downloads/dmenu-distrotube
	cd ~/Downloads/dmenu-distrotube/ && sudo make clean install && $(RM_CMD) config.h

ibus-bamboo:
	$(YAY_CMD) ibus-bamboo
	dconf load /desktop/ibus/ < ibus.dconf

themes:
	$(YAY_CMD) dracula-gtk-theme papirus-icon-theme papirus-folders
	papirus-folders -C indigo --theme Papirus-Dark

	$(RM_CMD) ~/Downloads/Qogir-Cursors-Recolored 
	mkdir -p ~/.local/share/icons
	$(GIT_CMD) https://github.com/TeddyBearKilla/Qogir-Cursors-Recolored --depth=1 ~/Downloads/Qogir-Cursors-Recolored
	cd ~/Downloads/Qogir-Cursors-Recolored/colors/Dracula/Purple && ./install.sh

fonts:
	$(YAY_CMD) noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-fira-code ttf-firacode-nerd ttf-iosevka-nerd ttf-liberation ttf-font-awesome

sshkey:
	ssh-keygen -t rsa -C "$(USER)"
	eval "$$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa
	bat ~/.ssh/id_rsa.pub
	xclip -sel clip < ~/.ssh/id_rsa.pub

devops:
	$(PACMAN_CMD) docker docker-compose docker-buildx minikube helm kubectl k9s
	sudo usermod -aG docker $(USER)

go:
	$(PACMAN_CMD) go

node:
	$(YAY_CMD) fnm-bin
	fnm install $(NODE_VERSION)

virtualbox:
	$(PACMAN_CMD) linux-headers virtualbox virtualbox-guest-utils
	sudo modprobe vboxdrv

docker-compose:
	$(PACMAN_CMD) docker-compose

update:
	sudo pacman -Syu
	$(YAY_CMD) -Syu

sudoers:
	sudo sh -c 'echo "$(USER) ALL=(ALL) NOPASSWD: /usr/bin/systemctl poweroff, /usr/bin/systemctl halt, /usr/bin/systemctl reboot" > /etc/sudoers.d/$(USER)'
	sudo visudo -c -f /etc/sudoers.d/$(USER)  # Check the syntax of the sudoers file

check-usb:
	lsblk -o NAME,SIZE,TYPE,MOUNTPOINT

find-iso:
	@iso_file=$$(find ../Downloads -type f -name "*.iso" | head -n 1); \
	if [ -z "$$iso_file" ]; then \
		echo "No ISO file found in Downloads."; \
		exit 1; \
	else \
		echo "Found ISO file: $$iso_file"; \
	fi

iso-to-usb: check-usb find-iso
	@iso_file=$$(find ../Downloads -type f -name "*.iso" | head -n 1); \
	read -p "Enter the USB device (e.g., /dev/sdb): " usb_device; \
	sudo dd if=$$iso_file of=$$usb_device bs=4M status=progress conv=fsync
