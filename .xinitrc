#Config file that gets sourced when you use startx or xinit

#set keyboard layout to de
setxkbmap -layout de

#set backgroun if tty=1
[[ $XDG_VTNR -eq 1 ]] && ~/.fehbg &
# start transparency
xcompmgr &

# start dunst to enable notifications
dunst &

#remap escape and capslock key
xmodmap ~/.Xmodmap

#start i3 window manager or xfce depending on tty
case $XDG_VTNR in
	1) exec i3 ;;
	2) exec startxfce4;;
	*) echo "I don't know what to on tty $XDG_VTRN"
esac
