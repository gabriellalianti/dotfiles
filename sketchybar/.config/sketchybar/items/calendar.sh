#!/bin/bash

sketchybar --add item calendar right    \
           --set calendar               \
                icon.drawing=off        \
                label.padding_left=10   \
                background.color=$GREEN \
                background.drawing=on   \
                label="--- -- --- --:--:-- --"
