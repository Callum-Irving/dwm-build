#!/bin/bash

delim="|"

volume() {
    if [ "$(awk -F'[][]' '/Left:/ { print $4 }' <(amixer sget Master))" = "on" ];
    then
        echo "🔊: $(awk -F'[][]' '/Left:/ { print $2 }' <(amixer sget Master))"
    else
        echo "🔇"
    fi

}

network() {
    if [ "$(nmcli c show --active | grep -E '(wifi|ethernet)')" = "" ];
    then
        echo "Disconnected"
    else
        echo "$(nmcli c show --active | grep -E '(wifi|ethernet)' | sed 's/ .*//')"
    fi
}

battery() {
    case "$(cat /sys/class/power_supply/BAT0/status)" in
        "Full")
            battery_status="FULL"
            ;;
        "Charging")
            battery_status="CHR"
            ;;
        "Discharging")
            battery_status="DIS"
            ;;
        *)
            battery_status="BATT?"
            ;; 
    esac

    echo "$battery_status: $(cat /sys/class/power_supply/BAT0/capacity)%"
}

crypto() {
    echo "BTC: \$$(printf '%.*f\n' 2 $(curl --silent cad.rate.sx/1btc))"
    # Make non-blocking
    # exec ~/.dwm/refreshbar.sh
}

statusbar() {
    echo "$(crypto)"
    echo "$delim"
    echo "$(volume)"
    echo "$delim"
    echo "$(network)"
    echo "$delim"
    echo "$(battery)"
    echo "$delim"
    echo "$(date "+%b %d %H:%M")"
}

# xset s 300 300
feh --bg-scale /home/callum/Pictures/Wallpapers/Wall21.jpg

while true; do
    xsetroot -name " $(statusbar | tr '\n' ' ')"
    sleep 1m
done
