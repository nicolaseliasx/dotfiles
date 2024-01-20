#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
#polybar -q main -c "$DIR"/config.ini &
if type "xrandr"; then
  if xrandr --query | grep "DP-4 connected"; then
    MONITOR=DP-4 polybar --reload main -c "$DIR"/config.ini &
  fi
else
  polybar --reload main -c "$DIR"/config.ini &
fi
