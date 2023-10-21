#!/bin/sh
if [ -z "$1" ]; then
  /usr/local/MATLAB/R2023b/bin/matlab -desktop
else
  /usr/local/MATLAB/R2023b/bin/matlab -desktop -r "edit('$1')"
fi
