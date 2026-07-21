#!/bin/bash

sketchybar --add item ram right \
           --set ram update_freq=2 \
                     icon=􀫦 \
                     background.color=$PURPLE \
                     background.drawing=on \
                     script="$PLUGIN_DIR/ram.sh"
