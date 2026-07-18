#!/bin/bash

sketchybar --add item front_app left \
           --set front_app \
                 background.drawing=on \
                 icon.color="$TEXT_COLOR" \
                 icon.font="sketchybar-app-font:Regular:12.0" \
                 label.color="$TEXT_COLOR" \
                 background.color=$PURPLE \
                 icon.color=$BLACK \
                 label.color=$BLACK \
                 script="$PLUGIN_DIR/front_app.sh" \
           --subscribe front_app front_app_switched
