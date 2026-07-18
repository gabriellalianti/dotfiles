#!/bin/bash

sketchybar --add event aerospace_workspace_change

WORKSPACES=""

for _ in {1..20}; do
  WORKSPACES="$(aerospace list-workspaces --all 2>/dev/null)"
  [[ -n "$WORKSPACES" ]] && break
  sleep 0.1
done

for sid in $WORKSPACES; do
  sketchybar \
    --add item "space.$sid" left \
    --subscribe "space.$sid" \
      aerospace_workspace_change \
      front_app_switched \
      space_windows_change \
    --set "space.$sid" \
      icon="$sid" \
      label.drawing=on \
      label.font="sketchybar-app-font:Regular:12.0" \
      label.padding_left=0 \
      label.padding_right=8 \
      label.y_offset=-1 \
      background.drawing=off \
      click_script="aerospace workspace $sid" \
      script="$PLUGIN_DIR/aerospace.sh"
done

sketchybar --add bracket aerospace_workspaces '/space\..*/' \
           --set aerospace_workspaces \
                 padding_left=0 \
                 padding_right=0 \
                 background.drawing=on \
