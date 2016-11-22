# Keyboard
setxkbmap -layout us,ru -option grp:alt_shift_toggle -option ctrl:nocaps -option compose:ralt &
kbdd &

# Multihead
xrandr --output HDMI2 --auto --output HDMI1 --auto --right-of HDMI2 &

# XResources
xrdb -merge ~/.Xresources &

# RXVT Deamon
#urxvtd -q -o -f &

# Background
. ~/.fehbg &

session=${1:-i3}

case $session in
	dwm)
		#Fix JVM apps
		wmname LG3D &
		dwmstatus &
		dwm
		;;
	i3)
		i3
		;;
esac
