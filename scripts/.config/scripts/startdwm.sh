#!/bin/bash
# relaunch DWM if the binary changes, otherwise bail
# csum=""
# new_csum=$(sha1sum "$(which dwm)")
# Run autostart file
if [ -f "$HOME/.config/scripts/autostart.sh" ]; then
    "$HOME/.config/scripts/autostart.sh" &
fi
# while true; do
# 	if [ "$csum" != "$new_csum" ]; then
# 		csum=$new_csum
# 		dwm
# 	else
# 		exit 0
# 	fi
# 	new_csum=$(sha1sum "$(which dwm)")
# 	sleep 0.5
# done
while true; do
    # Log stderror to a file
    dwm 2> ~/.dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done
