#!/bin/bash
# Checks for system updates and sends a notification if updates are available.
# Clicking the notification opens a terminal to run the update command.

UPDATES=$(checkupdates 2>/dev/null | wc -l)

if [ "$UPDATES" -gt 0 ]; then
    notify-send -u normal -a "System Update" \
        -i system-software-update \
        -c "im.portable.package" \
        "\U1F4E2 $UPDATES updates available" \
        "Click to open terminal and update" \
        -A "Update=alacritty -e bash -c 'echo To update, run: sudo pacman -Syu; exec bash'"
fi
