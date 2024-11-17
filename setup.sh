#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root."
  exit
fi

# Define the username (change it if necessary)
USERNAME=$(logname)

# Clone and install yay
echo "Cloning and installing yay..."
cd /home/$USERNAME
if [ ! -d "yay" ]; then
  sudo -u $USERNAME git clone https://aur.archlinux.org/yay.git
fi
cd yay
sudo -u $USERNAME makepkg -si --noconfirm

# Update repositories and system
echo "Updating system..."
pacman -Syu --noconfirm

# Install packages via pacman (official repos)
echo "Installing official packages via pacman..."
pacman -S --noconfirm wayland wayland-protocols copyq waybar swaylock thunar dolphin gammastep firefox chromium rofi-wayland lsd

# Install AUR packages via yay
echo "Installing AUR packages via yay..."
sudo -u $USERNAME yay -S --noconfirm wlroots-git wlogout

# Clean up yay build files
echo "Cleaning up yay build files..."
yay -Yc --noconfirm

echo "Installation complete!"
