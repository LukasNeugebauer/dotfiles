#Config file that gets sourced when you use startx or xinit

#find out if we're running on VNC
VNCSESSION=
SESSION=$(echo $DISPLAY | cut -d: -f2 )
[[ $SESSION -gt 0 ]] && VNCSESSION=SESSION

#do this is local session
if [[ -z $VNCSESSION ]]; then
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
        1) exec startxfce4;;
        2) exec i3 ;;
        *) echo "I don't know what to on tty $XDG_VTRN"
    esac
    ~/.screenlayout/.screen_ho.sh
fi
