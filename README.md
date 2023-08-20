# BatteryM
The most stupid and efficent battery management ever made for power-profiles-daemon

## What is this ? 

Well it's a power management utilty that I use for more than a year now and that can maybe be useful to other.

it checks if you're plugged in or not every 5 minutes and switch to the power saving if you're not and to balanced if you are plugged in.

if you set your computer to performance mode it wont switch automatically. that's an intended feature so you can set it with gamemode for instence and run a program without being interupted by a powerlimit.

## Install

`sh install.sh`

## Requirements
- upower
- power-profiles-daemon
- root for installation
