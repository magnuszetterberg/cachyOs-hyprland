# CachyOS Hyprland Configuration

My personal Hyprland desktop environment setup for CachyOS.

## Included Configurations

- **hypr/** - Hyprland window manager configuration
  - Main config, keybinds, autostart scripts
  - Audio idle inhibition script
  - Screenshot scripts
  
- **waybar/** - Status bar configuration
  - Custom modules and styling
  - Bluetooth toggle script
  - Media player integration
  
- **alacritty/** - Terminal emulator configuration
  
- **fish/** - Fish shell configuration
  - Shell config, functions, completions
  
- **wofi/** - Application launcher styling
  
- **wlogout/** - Logout menu styling
  
- **mako/** - Notification daemon configuration

- **swaylock/** - Screen lock configuration

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/magnuszetterberg/cachyOs-hyprland.git ~/github/cachyOs-hyprland
   ```

2. Backup your existing configs (if any):
   ```bash
   mv ~/.config/hypr ~/.config/hypr.backup
   mv ~/.config/waybar ~/.config/waybar.backup
   # etc...
   ```

3. Copy configs to your home directory:
   ```bash
   cp -r ~/github/cachyOs-hyprland/hypr ~/.config/
   cp -r ~/github/cachyOs-hyprland/waybar ~/.config/
   cp -r ~/github/cachyOs-hyprland/alacritty ~/.config/
   cp -r ~/github/cachyOs-hyprland/fish ~/.config/
   cp -r ~/github/cachyOs-hyprland/wofi ~/.config/
   cp -r ~/github/cachyOs-hyprland/wlogout ~/.config/
   cp -r ~/github/cachyOs-hyprland/mako ~/.config/
   cp -r ~/github/cachyOs-hyprland/swaylock ~/.config/
   ```

4. Make scripts executable:
   ```bash
   chmod +x ~/.config/hypr/scripts/*
   chmod +x ~/.config/waybar/*.sh
   ```

5. Install required packages:
   ```bash
   sudo pacman -S hyprland waybar alacritty fish wofi wlogout mako swaylock blueman network-manager-apple
   ```

## Features

- Bluetooth management with toggle and pairing GUI
- Audio idle inhibition (prevents sleep during media playback)
- Custom Waybar modules for system monitoring
- Integrated screenshot tools
- Spotify media controls

## Usage

- **Super + Q**: Open terminal (Alacritty)
- **Super + Return**: Open application launcher (Wofi)
- **Super + C**: Close focused window
- **Super + Shift + S**: Take screenshot (selection)
- **Super + E**: Open file manager (Nautilus)
- **Super + B**: Open browser (Firefox)
- **Super + L**: Lock screen (Swaylock)
- **Super + V**: Toggle floating mode
- **Super + R**: Enter resize mode
- **Super + 1-9**: Switch to workspace 1-9
- **Bluetooth icon**: Left-click to toggle, right-click for manager

Restart Hyprland or reboot to apply all changes.
