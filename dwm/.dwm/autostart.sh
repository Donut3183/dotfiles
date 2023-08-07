#!/usr/bin/zsh

autorandr --load triple_home &
sleep 1
picom -b  --config ~/.config/picom/picom.conf &
sxhkd -c ~/.config/sxhkd/sxhkdrc &
nm-applet &
/usr/bin/dunst &
blueberry-tray &
pasystray &
protonmail-bridge --no-window &
nextcloud &
firefox &
spotify-launcher &
thunderbird &
mullvad-vpn &
signal-desktop --start-in-tray &
<<<<<<< HEAD
solaar --window=hide &
=======
spotify-launcher &
# solaar --window=hide &
>>>>>>> 9589f8ea (Untracked cache from prusa slicer, updated dwm-bar script, dwm autostart added a blanking script used with udev)

sleep 1
feh --bg-fill /home/pontus/Nextcloud/Pictures/Wallapaper/gruvbox_Fnatic_Elements_Earth_Wallpaper_2560x1440.jpg &
<<<<<<< HEAD
sleep 5
if pgrep -x "dwm-bar" > /dev/null; then
else
    dwm-bar &
fi
connect-xm3 & > /dev/null 2>&1
=======
# sleep 5
# if pgrep -x "dwm-bar" > /dev/null; then
# else
#     dwm-bar &
# fi
>>>>>>> 9589f8ea (Untracked cache from prusa slicer, updated dwm-bar script, dwm autostart added a blanking script used with udev)
