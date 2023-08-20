#!/bin/bash

CURRENTPROFILE=$(powerprofilesctl get)

if [[ $CURRENTPROFILE == "performance" ]]
then
exit 0
fi

POWERSTATE=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "state")

if [[ $POWERSTATE == "    state:               charging" || $POWERSTATE == "    state:               fully-charged" ]]
then

powerprofilesctl set balanced
sudo cpupower frequency-set -g ondemand

else

powerprofilesctl set power-saver
cpupower frequency-set -g powersave
fi
