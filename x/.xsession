#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
autorandr --change &
vibrantcli.sh > /dev/null 2>&1 &
