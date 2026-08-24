#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"
BATT_INFO=$(pmset -g batt)
PERCENTAGE=$(echo "$BATT_INFO" | grep -Eo "[0-9]+%" | cut -d% -f1)
CHARGING=$(echo "$BATT_INFO" | grep -i "AC Power")
[ -n "$PERCENTAGE" ] || exit 0

if [ -n "$CHARGING" ]; then
  ICON="󰂄"
else
  case "$PERCENTAGE" in
    9[0-9]|100) ICON="󰁹" ;;
    7[0-9]|8[0-9]) ICON="󰂀" ;;
    4[0-9]|5[0-9]|6[0-9]) ICON="󰁾" ;;
    2[0-9]|3[0-9]) ICON="󰁼" ;;
    *) ICON="󰂃" ;;
  esac
fi

if [ "$PERCENTAGE" -lt 20 ]; then
  ICON_COLOR="$RED"
elif [ "$PERCENTAGE" -lt 60 ]; then
  ICON_COLOR="$PEACH"
else
  ICON_COLOR="$BLUE"
fi

sketchybar --set "$NAME" icon="$ICON" icon.background.color="$ICON_COLOR" label="${PERCENTAGE}%"
