NODE_VERSION ?= --lts

.PHONY: install

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

install: folder yay xorg qtile terminal utilities filemanager dmenu ibus-bamboo themes fonts
	sudo rm -rf ~/.bashrc
	stow --adopt .
xorg:
	sudo pacman -S --noconfirm xorg xorg-server xcolor
qtile:
	sudo pacman -S --noconfirm qtile python-psutil python-dbus-next
terminal:
	rm -rf ~/.config/nvim
	rm -rf ~/.local/share/nvim
	sudo pacman -S --noconfirm vi vim neovim
	sudo pacman -S --noconfirm kitty tmux fish fisher starship xclip ripgrep fzf eza bat zoxide feh jq wget htop lazygit fzf
utilities:
	sudo pacman -S --noconfirm picom lxappearance ly maim dunst gzip zip unzip p7zip unrar unarchiver xarchiver neofetch stow openssh inetutils alsa-utils xdg-utils 
	yay -S --noconfirm betterlockscreen ksuperkey
	sudo systemctl enable ly 
filemanager:
	sudo pacman -S --noconfirm pcmanfm ranger
dmenu:
	rm -rf ~/Downloads/dmenu-distrotube
	git clone https://gitlab.com/dwt1/dmenu-distrotube.git ~/Downloads/dmenu-distrotube
	cd ~/Downloads/dmenu-distrotube/ && sudo make clean install && rm -rf config.h
ibus-bamboo:
	yay -S --noconfirm ibus-bamboo
	dconf load /desktop/ibus/ < ibus.dconf
themes:
	yay -S --noconfirm dracula-gtk-theme papirus-icon-theme papirus-folders
	papirus-folders -C indigo --theme Papirus-Dark

	rm -rf ~/Downloads/Qogir-Cursors-Recolored 
	mkdir -p  ~/.local/share/icons
	git clone https://github.com/TeddyBearKilla/Qogir-Cursors-Recolored --depth=1 ~/Downloads/Qogir-Cursors-Recolored
	cd ~/Downloads/Qogir-Cursors-Recolored/colors/Dracula/Purple && ./install.sh
fonts:
	sudo pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-fira-code ttf-firacode-nerd ttf-iosevka-nerd ttf-liberation ttf-font-awesome
sshkey:
	ssh-keygen -t rsa -C "$(USER)"
	eval "$$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa
	bat ~/.ssh/id_rsa.pub
	xclip -sel clip < ~/.ssh/id_rsa.pub
devops:
	sudo pacman -S --noconfirm docker docker-compose docker-buildx minikube helm kubectl k9s
	sudo usermod -aG docker $(USER)
go:
	sudo pacman -S --noconfirm go
node:
	yay -S --noconfirm fnm-bin
	fnm install $(NODE_VERSION)
virtualbox:
	sudo pacman -S --noconfirm linux-headers virtualbox virtualbox-guest-utils
	sudo modprobe vboxdrv
