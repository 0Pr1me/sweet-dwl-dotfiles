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
pacman -S --noconfirm wayland wayland-protocols copyq waybar swaylock thunar dolphin gammastep firefox chromium rofi-wayland lsd fastfetch alacritty blueman

# Install AUR packages via yay
echo "Installing AUR packages via yay..."
sudo -u $USERNAME yay -S --noconfirm wlroots-git wlogout

# Clean up yay build files
echo "Cleaning up yay build files..."
yay -Yc --noconfirm

# Compile and install sweet-dwl compositor
# Step 1: Change to the 'sweet-dwl' directory

cd /sweet-dwl-dotfiles/
cd "$(dirname "$0")/sweet-dwl" || { echo "Directory sweet-dwl not found!"; exit 1; }

# Step 2: Run 'make' to compile the project
make || { echo "Make failed!"; exit 1; }

# Step 3: Run 'make install' to install the project
make install || { echo "Make install failed!"; exit 1; }

echo "Build and installation completed successfully."
cd ..
# Step 4: Copy the contents of the 'configs' directory to /home/.config
CONFIGS_DIR="$(dirname "$0")/configs"
if [ -d "$CONFIGS_DIR" ]; then
  echo "Copying config files to /home/.config"
  cp -r "$CONFIGS_DIR"/* /home/$(ls /home | head -n 1)/.config/ || { echo "Failed to copy config files!"; exit 1; }
else
  echo "Config directory not found!"
  exit 1
fi

# Step 5: Make contents of the 'scripts' directory executable and copy them to /usr/local/bin
SCRIPTS_DIR="$(dirname "$0")/scripts"
if [ -d "$SCRIPTS_DIR" ]; then
  echo "Making scripts executable and copying to /usr/local/bin"
  chmod +x "$SCRIPTS_DIR"/* || { echo "Failed to make scripts executable!"; exit 1; }
  cp "$SCRIPTS_DIR"/* /usr/local/bin/ || { echo "Failed to copy scripts!"; exit 1; }
else
  echo "Scripts directory not found!"
  exit 1
fi

echo "Configuration and script setup completed successfully."

echo "Setup complete!"
