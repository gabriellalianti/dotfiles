#!/bin/bash

sketchybar --add item cpu right \
           --set cpu  update_freq=2 \
                      icon=􀧓  \
                      background.color=$PURPLE \
                      background.drawing=on \
                      script="$PLUGIN_DIR/cpu.sh"
