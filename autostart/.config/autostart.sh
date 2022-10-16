#!/bin/sh
dwmblocks &
picom -f --config /home/pontus/.config/picom/picom.conf &
feh --bg-fil /home/pontus/Nextcloud/Pictures/Wallapaper/Fnatic_Elements_Earth_Wallpaper_2560x1440.jpg &
exec /home/pontus/.local/share/scripts/vibrantStartup.sh & 

#Autostart some nice programs
protonmail-bridge --no-window &
thunderbird &
signal-desktop &
calibre &
qbittorent &
firefox &

