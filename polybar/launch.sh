#!/usr/bin/bash

# terminate old instances if they're running
killall -q polybar

# run spotify-listener in the background
spotify-listener & disown

# launch new polybar on top, not bottom
echo "Starting polybar" | tee -a /tmp/polybar.log & disown
polybar top 2>&1 | tee -a /tmp/polybar.log & disown
