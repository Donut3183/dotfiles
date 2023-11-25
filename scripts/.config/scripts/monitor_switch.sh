#!/bin/sh

# Detect external monitors
external_monitor=$(xrandr | grep ' connected' | grep -v eDP)

# Check if any external monitors are connected
if [ -n "$external_monitor" ]; then
	# Turn off the laptop screen and use the external monitor
	xrandr --output eDP --off --output $(echo $external_monitor | cut -d' ' -f1) --auto
else
	# If no external monitors, turn on the laptop screen
	xrandr --output eDP --auto
fi
