#!/usr/bin/env bash

APP_NAME="$INFO"

if [ -z "$APP_NAME" ]; then
  APP_NAME=$(aerospace list-windows --focused --format '%{app-name}' 2>/dev/null)
fi

if [ -n "$APP_NAME" ]; then
  sketchybar --set "$NAME" label="$APP_NAME"
fi

exit 0
