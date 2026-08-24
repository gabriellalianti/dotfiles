#!/usr/bin/env bash

sketchybar --add item volume right \
           --subscribe volume volume_change \
           --set volume icon="󰕾" \
                 icon.color="$ICON_DARK_COLOR" \
                 icon.background.color="$BLUE" \
                 label.color="$TEXT_COLOR" \
                 script="$CONFIG_DIR/plugins/volume.sh"
