#!/bin/bash

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
  sketchybar \
    --add item "space.$sid" left \
    --subscribe "space.$sid" aerospace_workspace_change front_app_switched \
    --set "space.$sid" \
      icon="$sid" \
      icon.padding_left=8 \
      icon.padding_right=6 \
      label.drawing=on \
      label.font="sketchybar-app-font:Regular:16.0" \
      label.padding_left=0 \
      label.padding_right=8 \
      label.y_offset=-1 \
      background.color="$ACCENT_COLOR" \
      background.corner_radius=5 \
      background.height=24 \
      background.drawing=off \
      click_script="aerospace workspace $sid" \
      script="$PLUGIN_DIR/aerospace.sh"
done