#!/bin/bash
# ~/.config/waybar/modules/idle_inhibit_status.sh
# Outputs JSON for Waybar custom module: shows different icon if swayidle is inhibited by audio

# Check if the dummy swayidle process (from audio_idle_inhibit.sh) is running
if pgrep -f "swayidle -w timeout 9999999 'true'" > /dev/null; then
    # Inhibited (audio playing)
    echo '{"text": "", "tooltip": "Idle inhibited (audio playing)", "class": "inhibited"}'
else
    # Not inhibited
    echo '{"text": "", "tooltip": "Idle not inhibited", "class": "not-inhibited"}'
fi
