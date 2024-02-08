#!/usr/bin/zsh

autorandr --change &
sleep 1
picom -b --config ~/.config/picom/picom.conf &
sxhkd -c ~/.config/sxhkd/sxhkdrc &
nm-applet &
/usr/bin/dunst &
blueman-applet &
pasystray &
nextcloud &
firefox &
spotify-launcher &
thunderbird &
mullvad-vpn &
signal-desktop --start-in-tray &
spotify-launcher &
discord &
teams-for-linux &
protonmail-bridge &
syncthing &
xset s off -dpms

export XAUTHORITY=$(find /tmp -name 'xauth_*' -user pontus 2>/dev/null)
ln -sf "$XAUTHORITY" /home/pontus/.Xauthority
# solaar --window=hide &

feh --bg-fill /home/pontus/Nextcloud/Pictures/Wallapaper/gruvbox_Fnatic_Elements_Earth_Wallpaper_2560x1440.jpg &

if pgrep -x "dwm-bar" > /dev/null; then
  pkill dwm-bar && dwm-bar &
else
    dwm-bar &
fi
