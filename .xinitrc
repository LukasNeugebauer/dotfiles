#Config file that gets sourced when you use startx or xinit

#find out if we're running on VNC
VNCSESSION=
SESSION=$(echo $DISPLAY | cut -d: -f2 )
[[ $SESSION -gt 0 ]] && VNCSESSION=SESSION

#do this in local session
if [[ -z $VNCSESSION ]]; then

    #set backgroun if tty=1
    [[ $XDG_VTNR -eq 1 ]] && nitrogen --restore

    # start transparency, switched to picom
    # kicked out, not adding much and flickering windows sometimes
    #picom & disown

    # start dunst to enable notifications
    dunst & disown

<<<<<<< HEAD
=======
    #set keyboard layout to de for main computer
    [[ $(hostname) = 'archlinux' ]] && setxkbmap -layout de
    #remap escape and capslock key
    setxkbmap -option caps:swapescape

>>>>>>> 9d9f4653c05ee831c3e209f8b3b9499aade5480f
    #start i3 window manager or xfce depending on tty
    case $XDG_VTNR in
        1) exec i3 ;;
        *) echo "I don't know what to on tty $XDG_VTRN"
    esac
    #~/.screenlayout/.screen_ho.sh
fi
