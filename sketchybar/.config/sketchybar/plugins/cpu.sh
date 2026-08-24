#!/usr/bin/env bash

CORE_COUNT=$(sysctl -n hw.logicalcpu)
CPU_INFO=$(ps -Ao %cpu= | awk '{s+=$1} END {print s}')
CPU_USAGE=$(awk -v usage="$CPU_INFO" -v cores="$CORE_COUNT" 'BEGIN {printf "%02.0f", usage / cores}')
sketchybar --set "$NAME" label="${CPU_USAGE}%"
