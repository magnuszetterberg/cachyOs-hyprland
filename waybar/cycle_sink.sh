
#!/bin/bash
# Make sure to 'chmod 755 cycle_sink' to make it accessible for waybar

# Get a list of available sinks
sinks=($(pactl list short sinks | cut -f2))

# Determine the current default sink
currentSink=$(pactl info | sed -n 's/Default Sink: //p')

# Find the index of the current sink in the sinks array
currentIndex=-1
for i in "${!sinks[@]}"; do
    if [ "${sinks[i]}" = "$currentSink" ]; then
        currentIndex=$i
        break
    fi
done

# Calculate the index for the new sink
if [ $currentIndex -ge 0 ]; then
    newIndex=$(( (currentIndex + 1) % ${#sinks[@]} ))
    newSink="${sinks[newIndex]}"
else
    echo "Current sink not found in the list of available sinks."
    exit 1
fi

# Set the new default sink
pactl set-default-sink "$newSink"

# Move all sink inputs to the new default sink
pactl list short sink-inputs | while read stream; do
    streamId=$(echo $stream | cut '-d ' -f1)
    echo "Moving stream $streamId to sink $newSink"
    pactl move-sink-input "$streamId" "$newSink"
done