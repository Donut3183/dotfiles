#!/usr/bin/zsh

#autorandr --match-edid && autorandr --change & 
#vibrantcli.sh > /dev/null 2>&1 &
picom -b  --config ~/.config/picom/picom.conf &
#slstatus &
# firefox &
sxhkd -c ~/.config/sxhkd/sxhkdrc &
dwm-bar &
nm-applet &
/usr/bin/dunst &
#run "pamac-tray"
#run "xfce4-power-manager"
blueberry-tray &
#run "/usr/lib/xfce4/notifyd/xfce4-notifyd"
#run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
#run "numlockx on"
pasystray &
protonmail-bridge --no-window &
nextcloud &
# thunderbird &
mullvad-vpn &
# signal-desktop --start-in-tray &
# solaar --window=hide &
#
# sleep 1
feh --bg-fill /home/pontus/Nextcloud/Pictures/Wallapaper/gruvbox_Fnatic_Elements_Earth_Wallpaper_2560x1440.jpg
#

