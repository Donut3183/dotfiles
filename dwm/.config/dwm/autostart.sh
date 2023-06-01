#!/bin/bash

#autorandr --match-edid && autorandr --change & 
#vibrantcli.sh > /dev/null 2>&1 &
function run {
 if ! pgrep $1 ;
  then
    $@&
  fi
}

run "nm-applet"
run "pamac-tray"
run "variety"
run "xfce4-power-manager"
run "blueberry-tray"
run "/usr/lib/xfce4/notifyd/xfce4-notifyd"
run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
picom -b  --config ~/.config/arco-dwm/picom.conf &
run "numlockx on"
run "pasystray"
run slstatus &
#dwm_bar &
sxhkd -c ~/.config/arco-dwm/sxhkd/sxhkdrc &

#run applications from startup
protonmail-bridge --no-window &
nextcloud &
thunderbird &
mullvad-vpn &
signal-desktop --start-in-tray &
solaar --window=hide &

sleep 1
feh --bg-fill /home/pontus/Nextcloud/Pictures/Wallapaper/gruvbox_Fnatic_Elements_Earth_Wallpaper_2560x1440.jpg


