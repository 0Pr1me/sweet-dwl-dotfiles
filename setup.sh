#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root."
  exit
fi

# Define the username (change if necessary)
USERNAME=$(logname)
USER_HOME="/home/$USERNAME"

# Clone and install yay if not already installed
echo "Cloning and installing yay..."
cd $USER_HOME
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
pacman -S --noconfirm wayland wayland-protocols copyq waybar swaylock thunar dolphin gammastep firefox chromium rofi-wayland

# Install AUR packages via yay
echo "Installing AUR packages via yay..."
sudo -u $USERNAME yay -S --noconfirm wlroots-git wlogout

# Clean up yay build files
echo "Cleaning up yay build files..."
yay -Yc --noconfirm

# Copy the contents of the "configs" folder to ~/.config
echo "Copying configuration files to ~/.config..."
CONFIGS_DIR=$(dirname "$0")/configs

if [ -d "$CONFIGS_DIR" ]; then
  cp -r $CONFIGS_DIR/* $USER_HOME/.config/
  chown -R $USERNAME:$USERNAME $USER_HOME/.config
  echo "Configuration files copied successfully."
else
  echo "Warning: 'configs' directory not found."
fi

# Compile and install sweet-dwl compositor
SWEET_DWL_DIR=$(dirname "$0")/sweet-dwl

if [ -d "$SWEET_DWL_DIR" ]; then
  echo "Compiling and installing sweet-dwl..."
  cd $SWEET_DWL_DIR
  sudo -u $USERNAME make
  make install
  echo "sweet-dwl installed successfully."
else
  echo "Warning: 'sweet-dwl' directory not found."
fi

echo "Setup complete!"
