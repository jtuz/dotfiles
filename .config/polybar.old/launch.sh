#!/bin/sh

WM=$1
# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
# Launch xmonad-bar or i3-bar
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar ${WM}-bar >>/tmp/polybar1.log 2>&1 & disown

echo "Bars launched..."
