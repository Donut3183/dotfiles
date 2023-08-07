#!/bin/sh
export DISPLAY=:0
export XAUTHORITY=/home/pontus/.Xauthority
xset s off
xset -dpms

xset q > /home/pontus/xset_output.txt
