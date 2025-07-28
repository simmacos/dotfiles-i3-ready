#!/bin/bash

set -e

echo "🚀 Installing dotfiles and i3 setup..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function for colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   print_error "Don't run this script as root!"
   exit 1
fi

# Update system
print_status "Updating system..."
sudo pacman -Syu --noconfirm

# Install base packages
print_status "Installing base packages..."
sudo pacman -S --needed --noconfirm \
    i3-wm i3status i3blocks \
    dmenu rofi \
    firefox thunar \
    scrot feh \
    alacritty kitty \
    git vim nano \
    htop neofetch \
    brightnessctl \
    pavucontrol \
    xorg-xrandr arandr \
    xfce4-settings \
    network-manager-applet \
    blueman \
    unzip wget curl

# Install packages from your list
if [ -f "apps/packages.txt" ]; then
    print_status "Installing your custom packages..."
    sudo pacman -S --needed --noconfirm $(cat apps/packages.txt | grep -v "^#")
fi

# Setup i3 config
print_status "Setting up i3 configuration..."
mkdir -p ~/.config/i3
cp i3/config ~/.config/i3/
mkdir -p ~/.config/i3/scripts
cp i3/scripts/* ~/.config/i3/scripts/ 2>/dev/null || true
chmod +x ~/.config/i3/scripts/* 2>/dev/null || true

# Setup shell configs
print_status "Setting up shell configuration..."
[ -f "shell/.zshrc" ] && cp shell/.zshrc ~/.zshrc
[ -f "shell/.bashrc" ] && cp shell/.bashrc ~/.bashrc

# Setup system configs
print_status "Setting up system configuration..."
[ -f "system/logind.conf" ] && sudo cp system/logind.conf /etc/systemd/logind.conf

# Create wallpaper directory
mkdir -p ~/Pictures/wallpapers

# Set executable permissions for scripts
chmod +x ~/.config/i3/scripts/* 2>/dev/null || true

# Restart services
print_status "Restarting system services..."
sudo systemctl restart systemd-logind

print_status "✅ Installation complete!"
print_warning "Please reboot or log out and select i3 as your window manager"
print_warning "Don't forget to:"
echo "  - Set your wallpaper in ~/.wallpaper.png"
echo "  - Configure your monitor setup"
echo "  - Install AUR packages manually if needed"
