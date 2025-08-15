#!/bin/bash
# Checks for system updates and sends a notification if updates are available.
# Clicking the notification opens a terminal to run the update command.

UPDATES=$(checkupdates 2>/dev/null | wc -l)

if [ "$UPDATES" -gt 0 ]; then
    # Copy the update command to the clipboard (Wayland)
    echo "sudo pacman -Syu" | wl-copy
    notify-send -u normal -a "System Update" \
        -i system-software-update \
        -c "im.portable.package" \
        "\U1F4E2 $UPDATES updates available" \
        "Update command copied! Just paste in your terminal."
fi
