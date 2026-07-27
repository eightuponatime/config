#!/usr/bin/env bash

interface="wlp0s20f3"

ip_address="$(
    ip -4 -o addr show dev "$interface" 2>/dev/null |
    awk '{print $4}' |
    cut -d/ -f1 |
    head -n1
)"

bitrate="$(
    iw dev "$interface" link 2>/dev/null |
    awk '/tx bitrate:/ {
        print $3 " " $4
        exit
    }'
)"

if [[ -z "$ip_address" ]]; then
    printf '{"text":"WI-FI down","state":"Critical"}\n'
else
    [[ -z "$bitrate" ]] && bitrate="unknown"

    printf '{"text":"WI-FI %s (%s)","state":"Good"}\n' \
        "$bitrate" "$ip_address"
fi
