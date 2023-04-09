#!/bin/sh
export DISPLAY=:0
export XAUTHORITY=/home/pontus/.Xauthority
dispArray=()
SATURATION=2
MONITOR=$(xrandr | grep " connected " | awk 'END { print NR }')
j=1
for (( i=0; i<$MONITOR; i++ ))
do
	dispArray[$i]=$(xrandr | grep " connected " | awk 'NR=='$j' {print $1}')
	((j++))
done

function connect(){
	xrandr --fb 3840x1080 --output ${dispArray[1]} --off --output ${dispArray[2]} --crtc 2 --gamma 1.0:1.0:1.0 --mode 1920x1080 --pos 0x0 --rate 120.00 --reflect normal --rotate normal --set 'max bpc' 8 --set non-desktop 0 --set 'scaling mode' None --set TearFree on --set underscan off --set 'underscan hborder' 0 --set 'underscan vborder' 0
	xrandr --fb 3840x1080 --output ${dispArray[0]} --crtc 0 --gamma 1.0:1.0:1.0 --mode 1920x1080 --pos 1920x0 --primary --rate 120.00 --reflect normal --rotate normal --set 'max bpc' 8 --set non-desktop 0 --set 'scaling mode' None --scale 1x1 --set TearFree on --set underscan off --set 'underscan hborder' 0 --set 'underscan vborder' 0
	
	vibrant-cli ${dispArray[0]} $SATURATION > /dev/null 2>&1 &	
	vibrant-cli ${dispArray[1]} $SATURATION > /dev/null 2>&1 &	
	vibrant-cli ${dispArray[2]} $SATURATION > /dev/null 2>&1 &	
} 

function disconnect(){
	xrandr --fb 1791x1119 --output ${dispArray[0]} --transform none
	xrandr --fb 1791x1119 --output ${dispArray[0]} --crtc 0 --gamma 1.0:1.0:1.0 --mode 2560x1600 --pos 0x0 --primary --rate 60.00 --scale 0.7 --reflect normal --rotate normal --transform 0.699997,0.000000,0.000000,0.000000,0.699997,0.000000,0.000000,0.000000,1.000000 --set 'max bpc' 16 --set non-desktop 0 --set 'scaling mode' None --set TearFree on --set underscan off --set 'underscan hborder' 0 --set 'underscan vborder' 0
	vibrant-cli ${dispArray[0]} $SATURATION > /dev/null 2>&1 & 
}
if [[ $MONITOR -gt 1 ]]
then
 connect 
else
 disconnect
fi
