#Config file that gets sourced when you use startx or xinit

#find out if we're running on VNC
VNCSESSION=
SESSION=$(echo $DISPLAY | cut -d: -f2 )
[[ $SESSION -gt 0 ]] && VNCSESSION=SESSION

#do this in local session
if [[ -z $VNCSESSION ]]; then

    #set background if tty=1
    nitrogen --restore

    # start transparency, switched to picom
    # kicked out, not adding much and flickering windows sometimes
    picom & disown

    # start dunst to enable notifications
    dunst & disown

    #set keyboard layout to de for main computer
    [[ $(hostname) = 'archlinux' ]] && setxkbmap -layout de
    #remap escape and capslock key
    setxkbmap -option caps:swapescape

    # check monitors, if there's the two expected, apply the correct thing
    [[ $(xrandr --query | grep ' connected' | grep -E '(HDMI-0|DP-0)' | wc -l) -eq 2 ]] && ~/.screenlayout/office_dual_screen.sh

    #append PATH so shell scripts are accessible via rofi and dmenu
    export PATH=$PATH:"$HOME/shell_scripts"

    #start i3 window manager or xfce depending on tty
    case $XDG_VTNR in
        1) exec i3 ;;
        5) exec i3 ;;
        *) echo "I don't know what to on tty $XDG_VTRN"
    esac
    #~/.screenlayout/.screen_ho.sh
fi
