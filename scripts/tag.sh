#!/bin/sh

[[ "$1"  =~ "teddit" || "invidious" ]] && mpv > /dev/null 2>&1 "$1" || brave > /dev/null 2>&1 "$1"
