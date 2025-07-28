# 🖥️ My i3 Dotfiles Configuration

Personal i3 window manager configuration optimized for productivity and ThinkPad laptops.

## ✨ Features

- **i3wm** with custom keybindings and workflow optimization
- **Multi-monitor support** with automatic display switching on lid close/open
- **Battery management** with charge control for ThinkPad
- **Keyboard layout toggle** (Italian/English) with notifications
- **Power management** (suspend on lid close when on battery)
- **No built-in lock screen** (uses system default or GNOME's)
- **Display management** via xrandr and ACPI events

## 🚀 Quick Install

git clone https://github.com/simmacos/dotfiles-i3-ready.git ~/dotfiles-i3-ready
cd ~/dotfiles-i3-ready
chmod +x install.sh
./install.sh


Then log out and select **i3** from your display manager.

## 📋 What Gets Installed

### Core Packages
- **Window Manager**: i3-wm, i3status, i3blocks
- **Launcher**: dmenu, rofi
- **Applications**: firefox, thunar, alacritty
- **System Tools**: brightnessctl, pavucontrol, arandr, xfce4-settings
- **Utilities**: git, vim, htop, neofetch, scrot, feh

### Custom Configurations
- i3 window manager configuration
- Custom scripts for display/battery management
- Shell configurations (.zshrc, .bashrc)
- System-wide settings (logind.conf)

## ⌨️ Key Bindings

| Shortcut | Action |
|----------|--------|
| `Super + Return` | Open terminal |
| `Super + D` | Application launcher (dmenu) |
| `Super + W` | Firefox |
| `Super + E` | File manager (Thunar) |
| `Super + L` | Lock screen |
| `Super + C` | Close focused window |
| `Super + Ctrl + 0` | Toggle keyboard layout (IT/EN) |
| `Super + F` | Fullscreen toggle |
| `Super + Space` | Toggle floating mode |
| `Super + H/V` | Split horizontal/vertical |
| `Super + 1-6` | Switch to workspace |
| `Super + Shift + 1-6` | Move window to workspace |
| `Super + Arrow Keys` | Focus window direction |
| `Super + Shift + Arrow Keys` | Move window direction |

### Volume & Brightness
- `XF86AudioRaiseVolume/LowerVolume` → Volume control
- `XF86MonBrightnessUp/Down` → Brightness control

## 🔧 Special Features

### ThinkPad Battery Management
- Automatic charge control (limits charging to 80-85%)
- Battery monitoring with notifications

### Display Management
- **Lid closed + external monitor**: Uses external display only
- **Lid open**: Uses internal display (+ external as extended if connected)
- **ACPI events**: Automatic display switching

### Power Management
- **On battery**: Suspend on lid close
- **On AC power**: Ignore lid close when external monitor connected

## 📁 Repository Structure

~/dotfiles-i3-ready/
├── README.md # This file
├── install.sh # Automated installer
├── i3/
│ ├── config # Main i3 configuration
│ └── scripts/ # Custom scripts (battery, display, etc.)
├── system/
│ └── logind.conf # System power management
├── shell/
│ ├── .zshrc # Zsh configuration
│ └── .bashrc # Bash configuration
└── apps/
├── packages.txt # List of installed packages
└── aur-packages.txt # AUR packages (install manually)


## 🛠️ Post-Installation Setup

### 1. Set Wallpaper
cp your-wallpaper.png ~/.wallpaper.png


### 2. Configure Monitors
Use one of these tools for detailed monitor setup:
arandr # Simple GUI
xfce4-display-settings # Advanced GUI with refresh rate


### 3. Install AUR Packages (if needed)

yay -S $(cat apps/aur-packages.txt)

text

### 4. Keyboard Layout
The system includes IT/EN layout switching. Verify current layout:
setxkbmap -query


## 🔒 Lock Screen

This configuration doesn't include a built-in lock screen. Options:
- **GNOME users**: Uses `gnome-screensaver`
- **Alternative**: Install `i3lock-color` or `betterlockscreen`

## 🐛 Troubleshooting

### Display Issues
- Use `xrandr` to check connected displays
- Run `xfce4-display-settings` for GUI configuration
- Check ACPI events: `journalctl -u acpid`

### Battery Management
- Verify ThinkPad support: `cat /sys/class/power_supply/BAT0/charge_control_end_threshold`
- Check battery scripts: `~/.config/i3/scripts/`

### Keyboard Layout
- Manual switch: `setxkbmap it` or `setxkbmap us`
- Check notifications: ensure `libnotify` is installed

## 📝 Customization

### Adding New Keybindings
Edit `~/.config/i3/config` and add:
bindsym $mod+key exec your-command


### Custom Scripts
Add executable scripts to `~/.config/i3/scripts/` and reference them in the config.

### Modifying Power Behavior
Edit `/etc/systemd/logind.conf` or create override in `/etc/systemd/logind.conf.d/`

## 🤝 Contributing

Feel free to fork and adapt this configuration for your needs!

## 📄 License

Personal configuration - use freely!
