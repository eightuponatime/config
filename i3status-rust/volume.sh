#!/bin/sh

status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

if echo "$status" | grep -q MUTED; then
    printf '{"text":"VOL MUTE","state":"Critical"}\n'
else
    percent=$(echo "$status" | awk '{printf "%d", $2 * 100}')
    printf '{"text":"VOL %d%%","state":"Good"}\n' "$percent"
fi
