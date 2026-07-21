#!/bin/bash

TOTAL_MEMORY=$(sysctl -n hw.memsize)
RAM_PERCENT=$(vm_stat | awk -v total="$TOTAL_MEMORY" '
  /page size of/ { page_size = $8 }
  /Pages active:/ { active = $3 }
  /Pages wired down:/ { wired = $4 }
  /Pages occupied by compressor:/ { compressed = $5 }
  END {
    gsub(/\./, "", active)
    gsub(/\./, "", wired)
    gsub(/\./, "", compressed)

    if (total > 0 && page_size > 0) {
      printf "%.0f", 100 * (active + wired + compressed) * page_size / total
    } else {
      print "--"
    }
  }
')

sketchybar --set "$NAME" label="$RAM_PERCENT%"
