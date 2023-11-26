#!/usr/bin/zsh

autorandr --change &
sleep 1
picom -b --config ~/.config/picom/picom.conf &
sxhkd -c ~/.config/sxhkd/sxhkdrc &
nm-applet &
/usr/bin/dunst &
blueman-applet &
pasystray &
protonmail-bridge --no-window &
nextcloud &
firefox &
spotify-launcher &
thunderbird &
mullvad-vpn &
signal-desktop --start-in-tray &
spotify-launcher &
discord &

export XAUTHORITY=$(find /tmp -name 'xauth_*' -user pontus 2>/dev/null)
ln -sf "$XAUTHORITY" /home/pontus/.Xauthority
# solaar --window=hide &

sleep 1
feh --bg-fill /home/pontus/Nextcloud/Pictures/Wallapaper/gruvbox_Fnatic_Elements_Earth_Wallpaper_2560x1440.jpg &
# sleep 5
if pgrep -x "dwm-bar" > /dev/null; then
  pkill dwm-bar && dwm-bar &
else
    dwm-bar &
fi
