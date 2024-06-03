#!/bin/sh
# export QT_QPA_PLATFORM=xcb
export LD_PRELOAD="/usr/lib/libstdc++.so.6"
unset QT_SCREEN_SCALE_FACTORS
# /home/pontus/.config/scripts/matlab-scale.sh 2

if [ -z "$1" ]; then
	lockdev-redirect /usr/local/MATLAB/R2023b/bin/matlab -desktop
else
	lockdev-redirect /usr/local/MATLAB/R2023b/bin/matlab -desktop -r "edit('$1')"
fi
