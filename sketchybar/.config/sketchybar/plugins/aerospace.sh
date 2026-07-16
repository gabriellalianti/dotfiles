#!/bin/bash

source "$CONFIG_DIR/colors.sh"

SID="${NAME#space.}"
CURRENT_WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

APPS="$(
  aerospace list-windows \
    --workspace "$SID" \
    --format '%{app-name}' |
    sort -u
)"

ICON_STRIP=""

while IFS= read -r app; do
  [ -z "$app" ] && continue

  icon="$("$CONFIG_DIR/plugins/icon_map_fn.sh" "$app")"
  ICON_STRIP+=" $icon"
done <<< "$APPS"

if [ -z "$ICON_STRIP" ]; then
  ICON_STRIP=" —"
fi

if [[ "$SID" == "$CURRENT_WORKSPACE" ]]; then
  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color="$ACCENT_COLOR" \
    icon.color="$BAR_COLOR" \
    label.color="$BAR_COLOR" \
    label="$ICON_STRIP"
else
  sketchybar --set "$NAME" \
    background.drawing=off \
    icon.color="$ACCENT_COLOR" \
    label.color="$ACCENT_COLOR" \
    label="$ICON_STRIP"
fi