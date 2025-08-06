#!/bin/bash
# filepath: /home/magnus/.config/hypr/scripts/audio_idle_inhibit.sh

# This script inhibits swayidle when audio is playing via playerctl-compatible players.

INHIBIT_PID=""

while true; do
    if playerctl status 2>/dev/null | grep -q "Playing"; then
        # If not already inhibited, start a dummy swayidle process with a long timeout
        if [ -z "$INHIBIT_PID" ] || ! kill -0 "$INHIBIT_PID" 2>/dev/null; then
            swayidle -w timeout 9999999 'true' > /dev/null 2>&1 &
            INHIBIT_PID=$!
        fi
    else
        # If inhibited and audio stopped, kill the dummy swayidle process
        if [ -n "$INHIBIT_PID" ] && kill -0 "$INHIBIT_PID" 2>/dev/null; then
            kill "$INHIBIT_PID"
            INHIBIT_PID=""
        fi
    fi
    sleep 5
done
