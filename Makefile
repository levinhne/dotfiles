USER ?= $(shell whoami)  

.PHONY: install setup-folders install-yay install-xorg install-qtile install-terminal-tools install-utilities install-filemanager install-dmenu configure-ibus install-themes install-fonts configure-sudoers generate-ssh-key setup-devops install-golang install-nodejs install-virtualbox install-docker update-system check-usb find-iso iso-to-usb clean

PACMAN_CMD = sudo pacman -S --noconfirm
YAY_CMD = yay -S --noconfirm
GIT_CMD = git clone
RM_CMD = rm -rf

install: setup-folders install-yay install-xorg install-qtile install-terminal-tools install-utilities install-filemanager install-dmenu configure-ibus install-themes install-fonts install-golang install-nodejs configure-sudoers apply-dotfiles

setup-folders:
	cd ~ && mkdir -p {Desktop,Develop,Documents,Downloads,Pictures,Pictures/Wallpapers,Videos}
	sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
	sudo sed -i 's/#ParallelDownload/ParallelDownload/g' /etc/pacman.conf

install-yay:
	if ! command -v yay > /dev/null; then \
		$(RM_CMD) ~/Downloads/yay-bin/; \
		$(GIT_CMD) https://aur.archlinux.org/yay-bin.git ~/Downloads/yay-bin; \
		cd ~/Downloads/yay-bin/ && makepkg -si; \
		$(RM_CMD) yay-bin; \
	fi

install-xorg:
	$(PACMAN_CMD) xorg xorg-server xcolor

install-qtile:
	$(PACMAN_CMD) qtile python-psutil python-dbus-next

install-terminal-tools:
	$(RM_CMD) ~/.config/nvim ~/.local/share/nvim
	$(PACMAN_CMD) vi vim neovim kitty tmux fish fisher starship xclip ripgrep fzf eza bat zoxide feh jq wget htop lazygit

install-utilities: 
	$(PACMAN_CMD) picom ly maim dunst gzip zip unzip p7zip unrar unarchiver xarchiver neofetch stow openssh inetutils alsa-utils xdg-utils 
	$(PACMAN_CMD) bluez bluez-utils blueman
	$(YAY_CMD) ksuperkey redshift
	sudo systemctl enable ly 
	sudo sed -i 's/#AutoEnable=true/AutoEnable=true/g' /etc/bluetooth/main.conf
	sudo systemctl enable bluetooth

configure-lockscreen:
	$(YAY_CMD) slock

install-filemanager:
	$(PACMAN_CMD) qt5ct ranger

install-dmenu:
	$(RM_CMD) ~/Downloads/dmenu-distrotube
	$(GIT_CMD) https://gitlab.com/dwt1/dmenu-distrotube.git ~/Downloads/dmenu-distrotube
	cd ~/Downloads/dmenu-distrotube/ && sudo make clean install && $(RM_CMD) config.h

configure-ibus:
	$(YAY_CMD) ibus-bamboo
	dconf load /desktop/ibus/ < ibus.dconf

install-themes:
	$(YAY_CMD) dracula-gtk-theme papirus-icon-theme papirus-folders
	papirus-folders -C indigo --theme Papirus-Dark

	$(RM_CMD) ~/Downloads/Qogir-Cursors-Recolored 
	mkdir -p ~/.local/share/icons
	$(GIT_CMD) https://github.com/TeddyBearKilla/Qogir-Cursors-Recolored --depth=1 ~/Downloads/Qogir-Cursors-Recolored
	cd ~/Downloads/Qogir-Cursors-Recolored/colors/Dracula/Purple && ./install.sh

install-fonts:
	$(YAY_CMD) noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-fira-code ttf-firacode-nerd ttf-iosevka-nerd ttf-liberation ttf-font-awesome

configure-sudoers:
	sudo sh -c 'echo "$(USER) ALL=(ALL) NOPASSWD: /usr/bin/systemctl poweroff, /usr/bin/systemctl halt, /usr/bin/systemctl reboot" > /etc/sudoers.d/$(USER)'
	sudo visudo -c -f /etc/sudoers.d/$(USER)  # Kiểm tra cú pháp của file sudoers

generate-ssh-key:
	ssh-keygen -t rsa -C "$(USER)"
	eval "$$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa
	bat ~/.ssh/id_rsa.pub
	xclip -sel clip < ~/.ssh/id_rsa.pub

install-docker:
	$(PACMAN_CMD) docker docker-compose docker-buildx
	$(YAY_CMD) lazydocker
	sudo usermod -aG docker $(USER)

install-golang:
	$(PACMAN_CMD) go

install-nodejs:
	$(YAY_CMD) fnm-bin
	fnm install --lts

install-pyenv:
	$(YAY_CMD) pyenv

install-virtualbox:
	$(PACMAN_CMD) linux-headers virtualbox virtualbox-guest-utils
	sudo modprobe vboxdrv

apply-dotfiles:
	rm -rf ~/.bashrc
	stow . --adopt

check-usb:
	lsblk -o NAME,SIZE,TYPE,MOUNTPOINT

find-iso:
	@iso_file=$$(find ../Downloads -type f -name "*.iso" | head -n 1); \
	if [ -z "$$iso_file" ]; then \
		echo "Không tìm thấy file ISO trong thư mục Downloads."; \
		exit 1; \
	else \
		echo "Đã tìm thấy file ISO: $$iso_file"; \
	fi

iso-to-usb: check-usb find-iso
	@iso_file=$$(find ~/Downloads -type f -name "*.iso" | head -n 1); \
	read -p "Nhập thiết bị USB (ví dụ: /dev/sdb): " usb_device; \
	sudo dd if=$$iso_file of=$$usb_device bs=4M status=progress conv=fsync

clean:
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@find . -type f -name "*.pyc" -delete
	@find . -type f -name "*.pyo" -delete
