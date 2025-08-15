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
        " 🔔 $UPDATES updates available" \
        "Paste in your terminal to update."
    sleep 1
    notify-send -u low -a "System Update" \
        -i edit-paste \
        "Update command is now in your clipboard!"
fi
