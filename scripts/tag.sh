#!/bin/sh

[[ "$1"  =~ "teddit" || "invidious" ]] && mpv > /dev/null 2>&1 "$1" || librewolf > /dev/null 2>&1 "$1"
