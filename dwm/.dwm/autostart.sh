#!/usr/bin/zsh

picom -b  --config ~/.config/picom/picom.conf &
sxhkd -c ~/.config/sxhkd/sxhkdrc &
nm-applet &
/usr/bin/dunst &
blueberry-tray &
pasystray &
protonmail-bridge --no-window &
nextcloud &
thunderbird &
mullvad-vpn &
signal-desktop --start-in-tray &
# solaar --window=hide &

# sleep 1
feh --bg-fill /home/pontus/Nextcloud/Pictures/Wallapaper/gruvbox_Fnatic_Elements_Earth_Wallpaper_2560x1440.jpg &
sleep 5
dwm-bar &
