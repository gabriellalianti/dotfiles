#!/bin/bash

sketchybar --add item volume right \
           --set volume \
                 label.padding_right=10 \
                 background.color=$RED \
                 background.drawing=on \
                 script="$PLUGIN_DIR/volume.sh" \
           --subscribe volume volume_change
