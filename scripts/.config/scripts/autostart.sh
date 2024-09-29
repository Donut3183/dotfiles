#!/bin/sh

autorandr --change &
sleep 1
picom -b --config ~/.config/picom/picom.conf &
sxhkd -c ~/.config/sxhkd/sxhkdrc &
nm-applet &
/usr/bin/dunst &
blueman-applet &
pasystray &
nextcloud --background &
firefox &
# mullvad-browser &
spotify &
# bitwarden-desktop &
# chat-gpt &
thunderbird &
mullvad-vpn &
signal-desktop --start-in-tray &
discord --start-minimized &
# teams-for-linux &
protonmail-bridge &
qbittorrent &
# syncthing &
xset s off -dpms

export "XAUTHORITY=$(find /tmp -name 'xauth_*' -user pontus 2>/dev/null)"
ln -sf "$XAUTHORITY" /home/pontus/.Xauthority

solaar --window=hide &

# feh --bg-fill /home/pontus/Nextcloud/Pictures/Wallapaper/gruvbox_Fnatic_Elements_Earth_Wallpaper_2560x1440.jpg &
variety &

sleep 10
if pgrep -x "dwm-bar" >/dev/null; then
  pkill dwm-bar && dwm-bar &
else
  dwm-bar &
fi
