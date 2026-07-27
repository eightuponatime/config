#!/bin/sh

LIMIT=1.0

case "$1" in
    up)
        wpctl set-volume --limit "$LIMIT" @DEFAULT_AUDIO_SINK@ 5%+
        ;;
    down)
        wpctl set-volume --limit "$LIMIT" @DEFAULT_AUDIO_SINK@ 5%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
esac

status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

if echo "$status" | grep -q MUTED; then
    dunstify \
        -r 9993 \
        -t 700 \
        "🔇 Muted"
else
    percent=$(echo "$status" | awk '{printf "%d", $2 * 100}')

    dunstify \
        -r 9993 \
        -t 700 \
        -h int:value:$percent \
        "🔊" \
        "${percent}%"
fi

pkill -SIGUSR1 i3status-rs 2>/dev/null

