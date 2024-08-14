#    _               _
#   | |__   __ _ ___| |__  _ __ ___
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__
# (_)_.__/ \__,_|___/_| |_|_|  \___|
#
# by Stephan Raabe (2023)
# -----------------------------------------------------
# ~/.bashrc
# -----------------------------------------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
GREEN="\e[32m"
CYAN="\e[36m"
NOCOLOR="\e[37m"
function zed() {
    ~/.local/bin/zed "$@"
} 
# Define Editor
export EDITOR=neovide
function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------
alias sauce="source /home/osira/.bashrc"
#!/bin/bash
function yu(){
    yay -Syu "$@" --noconfirm --needed
}
function pu(){
    sudo pacman -Syu "$@" --noconfirm --needed
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


alias cbash="code ~/.bashrc"
my_fc_list() {
    #if no arguments are passed, list all fonts
    if [ -z "$1" ]; then
        fc-list :family | sort | uniq
    else
        #if a font name is passed, list all fonts that contain that name
        fc-list : family | sort | uniq | grep -i "$1"
    fi
    
}
function git(){
    
    for arg in "$@"; do
        if [[ "$arg" == "pull" ]]; then
        # save output to variable named "output"
            output="$(command git pull --rebase --autostash )"
            echo "$output"
            if [[ $output == *"CONFLICT"* ]]; then
                echo -e "${CYAN}--rebase --autostash used${NOCOLOR}"
                echo -e "if there are conflicts:"
                echo -e "${BLUE}    1. fix conflicts ${NOCOLOR}"
                echo -e "${YELLOW}    2. git add <file> ${NOCOLOR}"
                echo -e "${GREEN}    3. git rebase --continue ${NOCOLOR}"
            fi
            return 0
        fi
    done
    
    command git "$@"
    
    
}

function push(){
    git pull
    
    read -r -p "What will be added?" files
    while IFS= read -r file; do
        git add "$file"
    done <<< "$files"
    echo "Added files: $files"
    read -r -p "Commit message: " message
    git commit -m "$message"
    git push
}



alias sfont="my_fc_list"
alias c="code"
alias cs='clear'
alias nf='fastfetch'
alias pf='fastfetch'
alias ls='eza -1a --icons'
alias ll='eza -1al --icons'
alias lt='eza -1Ta --icons'
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias vim='$EDITOR'
alias ts='~/dotfiles/scripts/snapshot.sh'
alias matrix='cmatrix'
alias wifi='nmtui'
alias od='~/private/onedrive.sh'
alias rw='~/dotfiles/waybar/reload.sh'
alias winclass="xprop | grep 'CLASS'"
alias dot="cd ~/dotfiles"
alias cleanup='~/dotfiles/scripts/cleanup.sh'

# -----------------------------------------------------
# ML4W Apps
# -----------------------------------------------------
alias ml4w='~/dotfiles/apps/ML4W_Welcome-x86_64.AppImage'
alias ml4w-settings='~/dotfiles/apps/ML4W_Dotfiles_Settings-x86_64.AppImage'
alias ml4w-sidebar='~/dotfiles/eww/ml4w-sidebar/launch.sh'
alias ml4w-hyprland='~/dotfiles/apps/ML4W_Hyprland_Settings-x86_64.AppImage'
alias ml4w-diagnosis='~/dotfiles/scripts/diagnosis.sh'

# -----------------------------------------------------
# Window Managers
# -----------------------------------------------------

alias Qtile='startx'
# Hyprland with Hyprland

# -----------------------------------------------------
# GIT
# -----------------------------------------------------

alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gst="git stash"
alias gsp="git stash; git pull"
alias gcheck="git checkout"
alias gcredential="git config credential.helper store"

# -----------------------------------------------------
# SCRIPTS
# -----------------------------------------------------

alias gr='python ~/dotfiles/scripts/growthrate.py'
alias ChatGPT='python ~/mychatgpt/mychatgpt.py'
alias chat='python ~/mychatgpt/mychatgpt.py'
alias ascii='~/dotfiles/scripts/figlet.sh'

# -----------------------------------------------------
# VIRTUAL MACHINE
# -----------------------------------------------------

alias vm='~/private/launchvm.sh'
alias lg='~/dotfiles/scripts/looking-glass.sh'

# -----------------------------------------------------
# EDIT CONFIG FILES
# -----------------------------------------------------

alias confq='$EDITOR ~/dotfiles/qtile/config.py'
alias confp='$EDITOR ~/dotfiles/picom/picom.conf'
alias confb='$EDITOR ~/dotfiles/.bashrc'

# -----------------------------------------------------
# EDIT NOTES
# -----------------------------------------------------

alias notes='$EDITOR ~/notes.txt'

# -----------------------------------------------------
# SYSTEM
# -----------------------------------------------------

alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias setkb='setxkbmap de;echo "Keyboard set back to de."'

# -----------------------------------------------------
# SCREEN RESOLUTINS
# -----------------------------------------------------

# Qtile
alias res1='xrandr --output DisplayPort-0 --mode 2560x1440 --rate 120'
alias res2='xrandr --output DisplayPort-0 --mode 1920x1080 --rate 120'

export PATH="/usr/lib/ccache/bin/:$PATH"

# -----------------------------------------------------
# DEVELOPMENT
# -----------------------------------------------------
alias dotsync="~/dotfiles-versions/dotfiles/.dev/sync.sh dotfiles"

# -----------------------------------------------------
# START STARSHIP
# -----------------------------------------------------
eval "$(starship init bash)"
export NEXT_TELEMETRY_DISABLED=1
# ---------------------------------------------------

# -----------------------------------------------------
# PFETCH if on wm
# -----------------------------------------------------
echo ""
if [[ $(tty) == *"pts"* ]]; then
    fastfetch
else
    if [ -f /bin/qtile ]; then
        echo "Start Qtile X11 with command Qtile"
    fi
    if [ -f /bin/hyprctl ]; then
        echo "Start Hyprland with command Hyprland"
    fi
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# fnm
FNM_PATH="/home/osira/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
    export PATH="$FNM_PATH:$PATH"
    eval "`fnm env`"
fi

# pnpm
export PNPM_HOME="/home/osira/.local/share/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end