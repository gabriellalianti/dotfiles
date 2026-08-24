#!/usr/bin/env bash

sketchybar --add item battery right \
           --subscribe battery power_source_change system_woke \
           --set battery icon="󰁹" \
                 icon.font="$FONT_ICON" \
                 icon.background.drawing=on \
                 icon.background.color="$BLUE" \
                 icon.color="$ICON_DARK_COLOR" \
                 label="100%" \
                 label.color="$TEXT_COLOR" \
                 update_freq=120 \
                 script="$CONFIG_DIR/plugins/battery.sh"
