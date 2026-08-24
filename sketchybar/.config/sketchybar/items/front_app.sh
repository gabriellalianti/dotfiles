#!/usr/bin/env bash

sketchybar --add item front_app left \
           --subscribe front_app front_app_switched \
           --set front_app \
                 icon="󰣆" \
                 icon.color="$ICON_DARK_COLOR" \
                 icon.background.color="$BLUE" \
                 icon.background.height=26 \
                 icon.background.corner_radius=8 \
                 icon.background.drawing=on \
                 label="" \
                 label.color="$TEXT_COLOR" \
                 script="$CONFIG_DIR/plugins/front_app.sh"
