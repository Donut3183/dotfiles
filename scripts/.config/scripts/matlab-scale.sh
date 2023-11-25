#!/bin/sh
# Run this script with the scale factor you want and then start matlab the regular way
exec /usr/local/MATLAB/R2023b/bin/matlab -r "s = settings;s.matlab.desktop.DisplayScaleFactor.PersonalValue=$1;quit" -nodesktop -nosplash
