# Keyboard
setxkbmap -layout us,ru -option grp:alt_shift_toggle -option ctrl:nocaps -option compose:ralt &
kbdd &

# Load ~/.Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Turn off touchpad while typing for 1 sec after last keypress
syndaemon -i 1 -d -K

# Multihead
xrandr --output HDMI2 --auto --output HDMI1 --auto --right-of HDMI2 &

# NVIDIA specific
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# Set background image
sh ~/.fehbg &

# Run WM
i3
