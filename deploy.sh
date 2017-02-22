#!/bin/bash

declare -a targets=(
	"default"
	"acpilight"
	"bash"
	"git"
	"i3"
	"i3blocks"
	"look"
	"sway"
	"symlinks"
	"vim"
	"X"
)

if [[ $# -eq 0 ]]; then
	echo "Usage: ${0} targets"
	echo "Available targets:"
	for tg in "${targets[@]}"; do
	   echo "    ${tg}"
	done
	echo "default target contains: bash git vim symlinks look acpilight sway i3blocks"
	exit
fi

deploy_acpilight() {
	echo "Deploying acpilight"
	sudo cp acpilight/90-backlight.rules /etc/udev/rules.d/
	sudo cp acpilight/xbacklight /usr/local/bin/
	sudo udevadm control --reload-rules
}

deploy_bash() {
	echo "Deploying bash"
	cp bash/.bashrc ~/
}

deploy_git() {
	echo "Deploying git"
	cp git/.gitconfig ~/
}

deploy_i3() {
	echo "Deploying i3"
	if ! [[ -d ~/.i3 ]]; then
		mkdir ~/.i3
	fi
	cp i3/config ~/.i3/config
	cp i3/.i3status.conf ~/
}

deploy_i3blocks() {
	echo "Deploying i3blocks"
	if ! [[ -d ~/.config ]]; then
		mkdir ~/.config
	fi
	cp -r i3blocks ~/.config/
}

deploy_look() {
	echo "Deploying look and feel"
	cp X/.Xresources ~/
}

deploy_sway() {
	echo "Deploying sway"
	if ! [[ -d ~/.config/sway ]]; then
		mkdir -p ~/.config/sway
	fi
	cp sway/config ~/.config/sway/
	sudo cp sway/sway-launcher /usr/local/bin/
	sudo cp sway/custom-sway.desktop /usr/share/wayland-sessions/
}

deploy_symlinks() {
	user_home=~
	echo ${user_home}
	sudo ln -sf ${user_home}/.bashrc /root/.bashrc
	sudo ln -sf ${user_home}/.vim /root/.vim
	sudo ln -sf ${user_home}/.vimrc /root/.vimrc
}

deploy_vim() {
	echo "Deploying vim"
	cp -r vim/.vim ~/
	cp vim/.vimrc ~/
	vim -c ":PlugUpgrade | :PlugInstall | :qa"
}

deploy_X() {
	echo "Deploying X"
	cp X/.xinitrc ~/
}

for option in $@; do
	case ${option} in
	default)
		deploy_bash
		deploy_git
		deploy_vim
		deploy_symlinks
		deploy_look
		deploy_acpilight
		deploy_sway
		deploy_i3blocks
		;;
	acpilight) deploy_acpilight ;;
	bash) deploy_bash ;;
	git) deploy_git ;;
	i3) deploy_i3 ;;
	i3blocks) deploy_i3blocks ;;
	look) deploy_look ;;
	sway) deploy_sway ;;
	symlinks) deploy_symlinks ;;
	vim) deploy_vim ;;
	[xX]) deploy_X ;;
	*) echo "Unknown target" ;;
	esac
done
