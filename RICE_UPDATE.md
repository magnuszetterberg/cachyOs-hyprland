# Rice Update Script

## Quick Usage

From the repository directory:
```bash
./update_rice.sh
```

## What the script does:

1. **Backs up** existing configurations with timestamps
2. **Copies** all rice configurations from repo to `~/.config/`
3. **Makes scripts executable** (hypr scripts, waybar scripts)
4. **Reloads** Hyprland configuration
5. **Restarts** Waybar if running
6. **Shows summary** of what was updated

## Configurations updated:
- Hyprland window manager (`hypr/`)
- Waybar status bar (`waybar/`)
- Alacritty terminal (`alacritty/`)
- Fish shell (`fish/`)
- Wofi launcher (`wofi/`)
- WLogout logout menu (`wlogout/`)
- Mako notifications (`mako/`)
- Swaylock screen locker (`swaylock/`)

## Safety features:
- Automatic backups before overwriting
- Confirmation prompt before making changes
- Error handling and status reporting
- Preserves existing configs in timestamped backups
