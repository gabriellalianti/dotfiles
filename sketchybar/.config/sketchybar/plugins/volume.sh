#!/usr/bin/env bash

if [ "$SENDER" = "volume_change" ]; then
  sketchybar --set "$NAME" label="$INFO%"
fi
