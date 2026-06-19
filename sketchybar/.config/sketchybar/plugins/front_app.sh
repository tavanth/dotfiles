#!/bin/sh
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

WIN=$(aerospace list-windows --focused 2>/dev/null)

if [ -n "$WIN" ]; then
  TITLE=$(echo "$WIN" | awk -F' \\| ' '{print $3}')

  if [ "$SENDER" = "front_app_switched" ]; then
    sketchybar --set "$NAME" label="$INFO" drawing=on
  else
    APP=$(echo "$WIN" | awk -F' \\| ' '{print $2}')
    sketchybar --set "$NAME" label="$APP" drawing=on
  fi

  if [ -n "$TITLE" ]; then
    sketchybar --set file_label label="$TITLE" drawing=on
  else
    sketchybar --set file_label drawing=off
  fi
else
  sketchybar --set "$NAME" drawing=off
  sketchybar --set file_label drawing=off
fi
