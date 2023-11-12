#!/bin/sh
export QT_QPA_PLATFORM=xcb
if [ -z "$1" ]; then
	/usr/local/MATLAB/R2023b/bin/matlab -desktop
else
	/usr/local/MATLAB/R2023b/bin/matlab -desktop -r "edit('$1')"
fi
