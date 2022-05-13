#start xserver if we're
# 1) not on an ssh connection
# 2) have an active graphical target (whatever that might mean)
# 3) are on tty 1-3

if [[ -z $SSH_CONNECTION ]] && systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -le 3 ]]; then
  exec xinit
fi
