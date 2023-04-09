#!/bin/sh
xrandr --output DisplayPort-1 --primary --mode 1920x1080
xrandr --output DisplayPort-2 --mode 1920x1080 --left-of DisplayPort-1
xrandr --output eDP --off
vibrant-cli DisplayPort-1 2
vibrant-cli DisplayPort-2 2
