#!/usr/bin/env bash
set -e  # exit on errors

GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${GREEN}>>> Starting Sway install script...${RESET}"

# Ensure script is run as root (for pacman)
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run as root (sudo).${RESET}"
    exit 1
fi

#========================================================================================

pacman -Syu --noconfirm

pacman -S --needed --noconfirm git base-devel && git clone \
    https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si

pacman -S --needed --noconfirm sway swaybg swaylock waybar \
    kitty lf neovim nushell grim slurp wl-clipboard mako wofi

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#=======================================================================================

mkdir -p /home/$SUDO_USER/.config/{sway,waybar,alacritty,mako, nvim}
cp -r ./sway/*     ~/.config/sway/
cp -r ./waybar/*   ~/.config/waybar/
cp -r ./wofi/*     ~/.config/wofi/
cp -r ./kitty/*    ~/.config/kitty/
cp -r ./nvim/*     ~/.config/nvim/
cp -r ./nushell/*  ~/.config/nushell/
cp -r ./mako/*     ~/.config/mako/

# Set correct permissions
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config

echo -e "${GREEN}>>> Installation completed! PLS REBOOT.${RESET}"

