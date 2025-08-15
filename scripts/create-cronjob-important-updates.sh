#!/bin/bash
echo "Cronjob added: $CRON_LINE"
# Adds a daily cronjob to check for important updates and notify the user
CRON_LINE="0 10 * * * $HOME/github/cachyOs-hyprland/scripts/check_updates_notify.sh"

# Check if crontab is available, if not, install cronie
if ! command -v crontab >/dev/null 2>&1; then
    echo "crontab not found. Installing cronie..."
    sudo pacman -S --noconfirm cronie || { echo "Failed to install cronie."; exit 1; }
    sudo systemctl enable --now cronie || { echo "Failed to enable/start cronie service."; exit 1; }
fi

# Remove any existing matching cronjob before adding the new one
TMP_CRON=$(mktemp)
crontab -l 2>/dev/null | grep -vF "$CRON_LINE" > "$TMP_CRON"
echo "$CRON_LINE" >> "$TMP_CRON"
crontab "$TMP_CRON"
rm "$TMP_CRON"
echo "Cronjob added (and replaced any previous instance): $CRON_LINE"
