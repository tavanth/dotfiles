#!/bin/sh
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
sketchybar --set "$NAME" label="$WORKSPACE" drawing=on
