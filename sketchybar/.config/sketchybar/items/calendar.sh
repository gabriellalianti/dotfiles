#!/bin/bash

sketchybar --add item calendar right    \
           --set calendar               \
                icon.drawing=off        \
                label.padding_left=10   \
                background.color=$PURPLE \
                background.drawing=on   \
                label="--- -- --- --:--:-- --"
