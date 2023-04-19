
# Autostart applications
# /usr/lib/x86_64-linux-gnu/polkit-mate/polkit-mate-authentication-agent-1 &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
# nitrogen --restore; sleep 1; 
feh --bg-fill ~/.config/backgrounds/wallhaven-y8o51x_1920x1080.png &
DISPLAY=:0 feh --bg-fill ~/.config/backgrounds/wallhaven-y8o51x_1920x1080.png
#feh --bg-fill --no-xinerama --screen 0 ~/.config/backgrounds/wallhaven-y8o51x_1920x1080.png --rotate 90 & 
#feh --bg-fill ~/.config/backgrounds/wallhaven-6kvzxl_1920x1080.png &
# picom -b &
picom -b & --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 350 &
numlockx on &
nm-applet &
volumeicon &
dunst &
# blueman-applet &

# sxhkd
sxhkd -c ~/.config/i3/sxhkd/sxhkdrc &

xset s off -dpms

#Config telas
xrandr --output HDMI-0 --rotate right
xrandr --output DP-4 --mode 1920x1080 --rate 119.93
xrandr --output HDMI-0 --mode 1920x1080 --rate 60.00

xinput set-prop 18 'libinput Accel Speed' -0.7 &

slack &
spotify


