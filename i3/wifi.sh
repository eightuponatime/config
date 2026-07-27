#!/usr/bin/env bash

set -u

notify() {
    command -v dunstify >/dev/null &&
        dunstify -r 9994 -t 1500 "Wi-Fi" "$1"
}

if [[ "$(nmcli -t -f WIFI general)" != "enabled" ]]; then
    nmcli radio wifi on
    sleep 1
fi

nmcli device wifi rescan >/dev/null 2>&1
sleep 1

current_ssid="$(nmcli -t -f ACTIVE,SSID device wifi |
    awk -F: '$1 == "yes" {print substr($0, 5); exit}')"

networks="$(
    nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY device wifi list |
    awk -F: '
        $2 != "" && !seen[$2]++ {
            marker = ($1 == "*") ? "●" : " "
            security = ($4 == "--" || $4 == "") ? "open" : $4
            printf "%s %-30s %3s%%  %s\n", marker, $2, $3, security
        }
    '
)"

menu="$(
    {
        printf "󰖪  Disable Wi-Fi\n"
        [[ -n "$current_ssid" ]] && printf "󰖪  Disconnect from %s\n" "$current_ssid"
        printf "%s\n" "$networks"
    } | rofi -dmenu -i -p "Wi-Fi"
)"

[[ -z "$menu" ]] && exit 0

case "$menu" in
    "󰖪  Disable Wi-Fi")
        nmcli radio wifi off &&
            notify "Wi-Fi disabled"
        exit
        ;;
    "󰖪  Disconnect from "*)
        nmcli device disconnect "$(nmcli -t -f DEVICE,TYPE device |
            awk -F: '$2 == "wifi" {print $1; exit}')" &&
            notify "Disconnected"
        exit
        ;;
esac

ssid="$(
    sed -E \
        -e 's/^[● ] //' \
        -e 's/[[:space:]]+[0-9]+%[[:space:]]+.*$//' \
        <<< "$menu"
)"

[[ -z "$ssid" ]] && exit 1

if nmcli connection show "$ssid" >/dev/null 2>&1; then
    if nmcli connection up "$ssid"; then
        notify "Connected to $ssid"
    else
        notify "Failed to connect to $ssid"
    fi
    exit
fi

security="$(
    nmcli -t -f SSID,SECURITY device wifi list |
        awk -F: -v target="$ssid" '$1 == target {print $2; exit}'
)"

if [[ -z "$security" || "$security" == "--" ]]; then
    if nmcli device wifi connect "$ssid"; then
        notify "Connected to $ssid"
    else
        notify "Failed to connect to $ssid"
    fi
else
    password="$(
        rofi -dmenu -password -p "Password for $ssid"
    )"

    [[ -z "$password" ]] && exit 0

    if nmcli device wifi connect "$ssid" password "$password"; then
        notify "Connected to $ssid"
    else
        notify "Wrong password or connection failed"
    fi
fi
