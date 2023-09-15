#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=$(echo $XAUTHORITY)

if [ "$1" = "connected" ]; then
    xset s off
    xset -dpms
else
    xset s on
    xset +dpms
fi
