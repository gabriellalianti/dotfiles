#!/usr/bin/env bash

sketchybar --add event aerospace_workspace_change

WORKSPACES=""
for _ in {1..20}; do
  WORKSPACES="$(aerospace list-workspaces --all 2>/dev/null)"
  [[ -n "$WORKSPACES" ]] && break
  sleep 0.1
done

for sid in $WORKSPACES; do
  sketchybar --add item "space.$sid" left \
             --subscribe "space.$sid" aerospace_workspace_change front_app_switched space_windows_change \
             --set "space.$sid" \
                   icon="$sid" \
                   icon.font="$FONT_TEXT" \
                   icon.background.drawing=on \
                   label.font="sketchybar-app-font:Regular:12.0" \
                   label.padding_left=8 \
                   label.padding_right=8 \
                   label.y_offset=-1 \
                   background.color=0x00000000 \
                   click_script="aerospace workspace $sid" \
                   script="$CONFIG_DIR/plugins/aerospace.sh"
done
