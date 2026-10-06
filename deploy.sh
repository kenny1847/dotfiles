#!/bin/bash

deploy_ssh_agent() {
    mkdir -p -m 700 "${HOME}/.ssh" || return
    mkdir -p "${HOME}/.local/bin" || return
    install -m 700 ssh-agent/refresh-forwarded-agent \
        "${HOME}/.local/bin/refresh-forwarded-agent"
}

deploy_bash() {
    deploy_ssh_agent || return
    echo "Deploying bash"
    set -x
    mkdir -p "${HOME}/.bash"
    cp -r bash/bash/. "${HOME}/.bash/"
    cp bash/bashrc "${HOME}/.bashrc"
    set +x
}

deploy_git() {
    echo "Deploying git"
    set -x
    cp git/gitconfig ~/.gitconfig
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

deploy_tmux() {
    deploy_ssh_agent || return
    mkdir -p "${HOME}/.tmux"
    cp -r tmux/tmux/. "${HOME}/.tmux/"
    cp tmux/tmux.conf "${HOME}/.tmux.conf"
}

deploy_vim() {
    echo "Deploying vim"
    set -x
    cp -r vim/vim ~/.vim
    if ! [[ -d ~/.vim/undo ]]; then
        mkdir ~/.vim/undo
    fi
    cp vim/vimrc ~/.vimrc
    cp vim/arcadia.vimrc ~/.arcadia.vimrc
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

declare -a targets=(
    "default"
    "bash"
    "git"
    "rtags"
    "symlinks"
    "tmux"
    "vim"
    "X"
)

if [[ $# -eq 0 ]]; then
    echo "Usage: ${0} targets"
    echo "Available targets:"
    for tg in "${targets[@]}"; do
       echo "    ${tg}"
    done
    echo "default target contains: bash git vim tmux X"
    echo "bash and tmux also install the forwarded SSH agent helper"
    exit
fi

for option in $@; do
    case ${option} in
    default)
        deploy_bash
        deploy_git
        deploy_vim
        deploy_tmux
        deploy_X
        ;;
    bash) deploy_bash ;;
    git) deploy_git ;;
    rtags) deploy_rtags ;;
    symlinks) deploy_symlinks ;;
    tmux) deploy_tmux ;;
    vim) deploy_vim ;;
    [xX]) deploy_X ;;
    *) echo "Unknown target" ;;
    esac
done
