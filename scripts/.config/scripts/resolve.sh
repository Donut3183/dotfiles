#!/bin/bash

# export QT_AUTO_SCREEN_SCALE_FACTOR=2.0 # Adjust scaling factors as needed
# export QT_SCALE_FACTOR=2.0
export LD_PRELOAD="/usr/lib/libglib-2.0.so"

/opt/resolve/bin/resolve # Change the path if DaVinci Resolve is installed elsewhere
