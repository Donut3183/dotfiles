#!/bin/sh
virsh attach-device win10 $HOME/.VFIO/Mouse.xml
virsh attach-device win10 $HOME/.VFIO/Keyboard.xml
