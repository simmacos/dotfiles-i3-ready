#!/bin/bash

set -e

echo "🚀 Installing i3 dotfiles configuration..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

print_header() {
    echo -e "${BLUE}==== $1 ====${NC}"
}

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   print_error "Don't run this script as root!"
   exit 1
fi

print_header "System Update"
print_status "Updating system packages..."
sudo pacman -Syu --noconfirm

print_header "Installing Base Packages"
print_status "Installing i3 and essential packages..."
sudo pacman -S --needed --noconfirm \
    i3-wm i3status i3blocks \
    dmenu rofi \
    firefox thunar \
    scrot feh \
    alacritty \
    git vim nano \
    htop neofetch \
    brightnessctl \
    pavucontrol pulseaudio \
    xorg-xrandr arandr xfce4-settings \
    network-manager-applet \
    blueman \
    unzip wget curl \
    tree \
    xorg-xhost

print_header "Installing Custom Packages"
if [ -f "apps/packages.txt" ]; then
    print_status "Installing packages from your list..."
    while IFS= read -r package; do
        [[ $package =~ ^#.*$ ]] && continue  # Skip comments
        [[ -z $package ]] && continue        # Skip empty lines
        sudo pacman -S --needed --noconfirm "$package" 2>/dev/null || print_warning "Could not install: $package"
    done < "apps/packages.txt"
fi

print_header "Setting up i3 Configuration"
print_status "Creating i3 config directory..."
mkdir -p ~/.config/i3/scripts

print_status "Copying i3 configuration..."
cp i3/config ~/.config/i3/
cp i3/scripts/* ~/.config/i3/scripts/ 2>/dev/null || true
chmod +x ~/.config/i3/scripts/* 2>/dev/null || true

print_header "Setting up Shell Configuration"
[ -f "shell/.zshrc" ] && cp shell/.zshrc ~/.zshrc && print_status "Copied .zshrc"
[ -f "shell/.bashrc" ] && cp shell/.bashrc ~/.bashrc && print_status "Copied .bashrc"

print_header "Setting up System Configuration"
if [ -f "system/logind.conf" ]; then
    print_status "Configuring systemd-logind..."
    sudo cp system/logind.conf /etc/systemd/logind.conf
    sudo systemctl restart systemd-logind
fi

print_header "Final Setup"
print_status "Creating wallpaper directory..."
mkdir -p ~/Pictures/wallpapers

print_status "Setting up display permissions..."
xhost +local:root 2>/dev/null || print_warning "Could not set xhost permissions"

print_header "Installation Complete!"
print_status "✅ i3 dotfiles installed successfully!"
echo ""
print_warning "Next steps:"
echo "  1. Log out and select 'i3' from your display manager"
echo "  2. Add your wallpaper: cp your-image.png ~/.wallpaper.png"
echo "  3. Configure monitors with: arandr or xfce4-display-settings"
echo "  4. Install AUR packages manually from apps/aur-packages.txt"
echo ""
print_warning "Key bindings:"
echo "  Super + Return      → Terminal"
echo "  Super + D           → Application launcher"
echo "  Super + W           → Firefox"
echo "  Super + E           → File manager"
echo "  Super + Ctrl + 0    → Toggle keyboard layout"
echo "  Super + C           → Close window"
