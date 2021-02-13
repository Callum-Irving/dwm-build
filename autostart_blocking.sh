#!/bin/bash
killall autostart.sh
feh --bg-scale /home/callum/Pictures/Wallpapers/Wall21.jpg
xset s 300 300
picom &>/dev/null &
lxsession &>/dev/null &
light-locker --lock-after-screensaver 30 &>/dev/null &
# volumeicon &
# trying to use nmcli instead of this gui app
# nm-applet &
