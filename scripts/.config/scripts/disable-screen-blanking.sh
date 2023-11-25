#!/bin/bash

# Read the current status of the AC adapter
AC_STATUS=$(cat /sys/class/power_supply/ACAD/online)

if [ "$AC_STATUS" -eq 1 ]; then
	xset s off -dpms
else
	xset s on +dpms
fi
