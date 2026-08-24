#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

SID="${NAME#space.}"
CURRENT_WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"
APPS="$(aerospace list-windows --workspace "$SID" --format '%{app-name}' 2>/dev/null | sort -u)"
ICON_STRIP=""

while IFS= read -r app; do
  [ -z "$app" ] && continue
  icon="$("$CONFIG_DIR/plugins/icon_map_fn.sh" "$app")"
  ICON_STRIP+="  $icon"
done <<< "$APPS"

ICON_STRIP="${ICON_STRIP#  }"
[ -n "$ICON_STRIP" ] || ICON_STRIP="—"

if [[ "$SID" == "$CURRENT_WORKSPACE" ]]; then
  sketchybar --set "$NAME" \
    icon.color="$ICON_DARK_COLOR" icon.background.color="$PEACH" \
    background.color="$SURFACE_COLOR" label="$ICON_STRIP" \
    label.color="$TEXT_COLOR" label.width=dynamic
else
  sketchybar --set "$NAME" \
    icon.color="$TEXT_COLOR" icon.background.color="$SURFACE_COLOR" \
    background.color="$SURFACE_COLOR" label="$ICON_STRIP" \
    label.color="$TEXT_COLOR" label.width=dynamic
fi
