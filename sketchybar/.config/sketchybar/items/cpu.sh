#!/usr/bin/env bash

sketchybar --add item cpu right \
           --set cpu icon="" \
                 icon.font="$FONT_DISPLAY" \
                 icon.background.drawing=on \
                 icon.background.color="$BLUE" \
                 icon.background.height=26 \
                 icon.background.corner_radius=8 \
                 icon.color="$ICON_DARK_COLOR" \
                 label="--" \
                 label.font="$FONT_TEXT" \
                 label.color="$TEXT_COLOR" \
                 update_freq=2 \
                 script="$CONFIG_DIR/plugins/cpu.sh"
