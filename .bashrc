#!/bin/bash
function sos(){
    source /home/osira/.bashrc
}
function dhr(){
    sudo systemctl restart dhcpcd
}
function nmr(){
    sudo systemctl restart NetworkManager
}
function nwr(){
    dhr && nmr
}
function clean_trash(){
    sudo rm -rf ~/.local/share/Trash/files/*
    sudo rm -rf ~/.local/share/Trash/info/*
}
function pc(){
    paru -Sccd
}
function pu(){
    sudo paru -Syu "$@" --noconfirm --needed  --batchinstall
}
function fc_list() {
    #if no arguments are passed, list all fonts
    if [ -z "$1" ]; then
        fc-list :family | sort | uniq
    else
        #if a font name is passed, list all fonts that contain that name
        fc-list : family | sort | uniq | rg -i "$1"
    fi
}

function refresh_font_cache() {
    sudo fc-cache -fv
}

function hysl(){
    sudo systemctl hybrid-sleep
}

function rdisk() {
    local path=""
    local size=""
    local unmount="false"
    # Parse command-line arguments
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -p|--path)
                path="$2"
                shift
            ;;
            -s|--size)
                size="$2"
                shift
            ;;
            -u|--unmount)
                unmount="true"
            ;;
            *)
                echo "Unknown parameter passed: $1"
                exit 1
            ;;
        esac
        shift
    done
    if [[ -z "$path" ]]; then
        echo "Error: path is required"
        exit 1
    fi
    if [[ "$unmount" == "true" ]]; then
        echo "Unmounting $path"
        sudo umount $path
        sudo rmdir $path
    else
        if [[ -z "$size" ]]; then
            echo "Error: size is required for mounting"
            exit 1
        fi
        echo "Mounting tmpfs at $path with size $size"
        sudo mount -m -t tmpfs -o size=$size tmpfs $path
    fi
}
function install_paru(){
    cargo install paru --git https://github.com/Morganamilo/paru --tag v2.0.4
}
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(bat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
function remove_unused(){
    sudo pacman -Rns $(pacman -Qdtq)
}