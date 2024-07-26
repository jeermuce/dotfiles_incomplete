#!/bin/bash
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

# Define Editor
export EDITOR=neovide
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export NC='\033[0m' # No Color



# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------


function biojsonc() {
# Ensure the script runs in the directory where the biome.jsonc file is located
if [ ! -f biome.jsonc ]; then
    echo "biome.jsonc not found in the current directory."
    return 1
fi
read -r -p "Do you want to replace biome.jsonc with the new configuration? [Y/n] " replace
 if  [ "$replace" = "n" ] || [ "$replace" = "N" ] ; then
    echo "Skipping biome.jsonc replacement."
    return 0
fi
# Define the new content
new_content='{
  "$schema": "https://biomejs.dev/schemas/1.8.3/schema.json",
  "organizeImports": {
    "enabled": true
  },
  "vcs": {
    "enabled": true,
    "clientKind": "git",
    "useIgnoreFile": true
  },
  "linter": {
    "enabled": true,
    "rules": {
      "recommended": true,
      "complexity": {
        "useArrowFunction": "off"
      },
      "style": {
        "useNodejsImportProtocol": "off"
      }
    }
  },
  "formatter": {
    "enabled": true,
    "formatWithErrors": false,
    "indentStyle": "space",
    "indentWidth": 2,
    "lineEnding": "lf",
    "lineWidth": 80,
    "attributePosition": "auto"
  },
  "files": {
    "ignoreUnknown": true
  }
}

'

    # Replace the contents of biome.jsonc with the new content
    echo "$new_content" > biome.jsonc
    cat biome.jsonc

    # Check if the replacement was successful
    if grep -q '"$schema": "https://biomejs.dev/schemas/1.8.3/schema.json"' biome.jsonc; then
      echo "biome.jsonc updated successfully."
    else
      echo "Failed to update biome.jsonc."

    fi

}

  # Use sed with a different delimiter to avoid conflicts with slashes in paths


function bioset() {
  bun add --save-dev --save-exact @biomejs/biome && \
  bunx @biomejs/biome init --jsonc && \
  #ask if want to replace package.json
  biomejsonc

}
alias setus="setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl"
alias setcarp="setxkbmap -rules evdev -model evdev -layout us -variant carpalx-altgr-intl"
alias dhnm="sudo systemctl restart dhcpcd && sudo systemctl restart NetworkManager.service"
alias dhr="sudo systemctl restart dhcpcd"
alias nms="sudo systemctl restart NetworkManager.service"
alias cat="bat"
alias bul="bun oxlint . --fix --jsdoc-plugin --react-perf-plugin --jest-plugin --jsx-a11y-plugin --nextjs-plugin --import-plugin --disable-react-plugin --disable-unicorn-plugin --disable-oxc-plugin --disable-typescript-plugin && bun eslint . --fix"
alias sauce="source /home/osira/.bashrc"
alias treeg="tree --gitignore"
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias yu='yay -Syu --noconfirm'
alias pu='sudo pacman -Syu --noconfirm'
alias yi='yay -S'
alias pi='sudo pacman -S'
alias push="/home/osira/.scripts/push.sh"
alias fix="/home/osira/.scripts/fix.sh"
alias grep="rg"
alias kanaka="kanata -nc ~/kanata.kbd"

function ramdisk() {
  local path=""
  local size=""
  local unmount="false"

  function show_help() {
    echo "Usage: rdisk [OPTIONS]"
    echo "Options:"
    echo "  -p, --path PATH    Specify the mount path"
    echo "  -s, --size SIZE    Specify the size for the tmpfs (required for mounting)"
    echo "  -u, --unmount      Unmount the specified path"
    echo "  -h, --help         Display this help message"
  }

  # Parse command-line arguments
  while [[ "$#" -gt 0 ]]; do
    case $1 in
      -p|--path)
        path="$2"
        shift 2
        ;;
      -s|--size)
        size="$2"
        shift 2
        ;;
      -u|--unmount)
        unmount="true"
        shift
        ;;
      -h|--help)
        show_help
        return 0
        ;;
      *)
        echo "Unknown parameter passed: $1"
        show_help
        return 1
        ;;
    esac
  done

  if [[ -z "$path" ]]; then
    echo "Error: path is required"
    show_help
    return 1
  fi

  if [[ "$unmount" == "true" ]]; then
    echo "Unmounting $path"
    sudo umount "$path"
    sudo rmdir "$path"
  else
    if [[ -z "$size" ]]; then
      echo "Error: size is required for mounting"
      show_help
      return 1
    fi
    echo "Mounting tmpfs at $path with size $size"
    sudo mount -m -t tmpfs -o size="$size" tmpfs "$path"
  fi
}



alias rdisk="ramdisk"
alias cbash="code ~/.bashrc"
my_fc_list() {
  #if no arguments are passed, list all fonts
  if [ -z "$1" ]; then
    fc-list :family | sort | uniq
  else
    #if a font name is passed, list all fonts that contain that name
    fc-list : family | sort | uniq | rg -i "$1"
  fi

}
alias sfont=my_fc_list
alias c="code"
alias cs='clear' 
alias nf='neofetch'
alias pf='pfetch'
alias tree="eza --icons --git-ignore -a1TL"
alias ls='eza --icons -li1'
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
    pfetch
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
