#!/bin/bash

declare -a targets=(
	"default"
	"acpilight"
	"bash"
	"git"
	"rtags"
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
	echo "default target contains: bash git vim rtags symlinks acpilight"
	exit
fi

deploy_acpilight() {
	echo "Deploying acpilight"
	set -x
	sudo cp ./dependencies/acpilight/90-backlight.rules /etc/udev/rules.d/
	sudo cp ./dependencies/acpilight/xbacklight /usr/local/bin/
	sudo udevadm control --reload-rules
	set +x
}

deploy_bash() {
	echo "Deploying bash"
	set -x
	cp bash/.bashrc ~/
	set +x
}

deploy_git() {
	echo "Deploying git"
	set -x
	cp git/.gitconfig ~/
	set +x
}

deploy_rtags() {
	echo "Deploying rtags"
	set -x
	if ! [[ -d ~/.config/systemd/user ]]; then
		mkdir -p ~/.config/systemd/user
	fi
	cp rtags/* ~/.config/systemd/user/
	set +x
}

deploy_symlinks() {
	user_home=~
	set -x
	sudo ln -sf ${user_home}/.bashrc /root/.bashrc
	sudo ln -sf ${user_home}/.vim /root/.vim
	sudo ln -sf ${user_home}/.vimrc /root/.vimrc
	set +x
}

deploy_vim() {
	echo "Deploying vim"
	set -x
	cp -r vim/.vim ~/
	if ! [[ -d ~/.vim/undo ]]; then
		mkdir ~/.vim/undo
	fi
	cp vim/.vimrc ~/
	vim -c ":PlugUpgrade | :PlugInstall | :qa"
	set +x
}

deploy_X() {
	echo "Deploying X"
	set -x
	cp X/.xinitrc ~/
	cp X/.Xresources ~/
	set +x
}

for option in $@; do
	case ${option} in
	default)
		deploy_bash
		deploy_git
		deploy_vim
		deploy_rtags
		deploy_symlinks
		deploy_acpilight
		;;
	acpilight) deploy_acpilight ;;
	bash) deploy_bash ;;
	git) deploy_git ;;
	rtags) deploy_rtags ;;
	symlinks) deploy_symlinks ;;
	vim) deploy_vim ;;
	[xX]) deploy_X ;;
	*) echo "Unknown target" ;;
	esac
done
