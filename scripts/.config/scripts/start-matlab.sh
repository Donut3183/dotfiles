#!/bin/sh
# export QT_QPA_PLATFORM=xcb
if [ -z "$1" ]; then
	lockdev-redirect /opt/matlab/R2023b/bin/matlab -desktop
else
	lockdev-redirect /opt/matlab//R2023b/bin/matlab -desktop -r "edit('$1')"
fi
