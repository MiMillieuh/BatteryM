#!/bin/bash

CURRENTPROFILE=$(powerprofilesctl get)
BatteryFolder="/opt/batterym/onbatteryscripts"
PluggedInFolder="/opt/batterym/pluggedincripts"
StateFile="/opt/batterym/powerstate"

if [[ $CURRENTPROFILE == "performance" ]]; then
    exit 0
fi

POWERSTATE=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "state" | awk '{print $2}')

if [ -f "$StateFile" ]; then
    PreviousState=$(cat "$StateFile")
else
    PreviousState=""
fi

echo "$POWERSTATE" > "$StateFile"

if [[ $POWERSTATE != $PreviousState ]]; then
    if [[ $POWERSTATE == "charging" || $POWERSTATE == "fully-charged" ]]; then

        powerprofilesctl set balanced
        sudo cpupower frequency-set -g ondemand

        for script in "$PluggedInFolder"/*; do
            if [ -x "$script" ]; then
                echo "Executing $script"
                "$script"
            else
                echo "$script Is not executable or not a file"
            fi
        done

    else

        powerprofilesctl set power-saver
        cpupower frequency-set -g powersave

        for script in "$BatteryFolder"/*; do
            if [ -x "$script" ]; then
                echo "Executing $script"
                "$script"
            else
                echo "$script Is not executable or not a file"
            fi
        done

    fi
fi
