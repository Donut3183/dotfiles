#!/bin/sh
# Run this script with the scale factor you want and then start matlab the regular way
/usr/local/MATLAB/R2023a/bin/matlab -r "s = settings;s.matlab.desktop.DisplayScaleFactor.PersonalValue=$1;quit" -nodesktop -nosplash

# Send notification using Dunst
notify-send "MATLAB Scaling Complete" "MATLAB scaling operation with factor $1 is complete."

notify-send "Starting matlab."
/usr/local/bin/start-matlab
