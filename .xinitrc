#Config file that gets sourced when you use startx or xinit

#set keyboard layout to de
setxkbmap -layout de

# set background image
~/.fehbg &

# start transparency
xcompmgr &

# start dunst to enable notifications
duns &

#remap escape and capslock key
xmodmap ~/.Xmodmap

#start i3 window manager
exec i3
