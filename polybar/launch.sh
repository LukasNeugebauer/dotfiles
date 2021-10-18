#!/usr/bin/bash

#determine bar type depending on hostname
name=$(hostname)
if [ $name = anarchy ]; then
    bartype=laptop
else
    bartype=default
fi

# terminate old instances if they're running
killall -q polybar

# run spotify-listener in the background
spotify-listener & disown

# launch new polybar on top, not bottom
# check if xrandr is available to draw for all connected monitors
if type xrandr; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload $bartype & disown
    done
else
    polybar --reload $bartype & disown
fi
