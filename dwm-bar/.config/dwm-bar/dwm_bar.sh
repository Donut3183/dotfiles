#!/bin/sh

# A modular status bar for dwm
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: xorg-xsetroot

# Import functions with "$include /route/to/module"
# It is recommended that you place functions in the subdirectory ./bar-functions and use: . "$DIR/bar-functions/dwm_example.sh"

# Store the directory the script is running from
LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC"5)

# Change the appearance of the module identifier. if this is set to "unicode", then symbols will be used as identifiers instead of text. E.g. [📪 0] instead of [MAIL 0].
# Requires a font with adequate unicode character support
export IDENTIFIER="unicode"

# Change the character(s) used to separate modules. If two are used, they will be placed at the start and end.
export SEP1=""
export SEP2="|"

# Import the modules
#. "$DIR/bar-functions/dwm_alarm.sh"
#. "$DIR/bar-functions/dwm_alsa.sh"
. "$DIR/bar-functions/dwm_packages.sh"
# . "$DIR/bar-functions/dwm_backlight.sh"
. "$DIR/bar-functions/dwm_battery.sh"
#. "$DIR/bar-functions/dwm_ccurse.sh"
#. "$DIR/bar-functions/dwm_cmus.sh"
#. "$DIR/bar-functions/dwm_connman.sh"
#. "$DIR/bar-functions/dwm_countdown.sh"
#. "$DIR/bar-functions/dwm_currency.sh"
. "$DIR/bar-functions/dwm_date.sh"
#. "$DIR/bar-functions/dwm_keyboard.sh"
#. "$DIR/bar-functions/dwm_loadavg.sh"
# . "$DIR/bar-functions/dwm_mail.sh"
# . "$DIR/bar-functions/dwm_mpc.sh"
# . "$DIR/bar-functions/dwm_networkmanager.sh"
#. "$DIR/bar-functions/dwm_pulse.sh"
. "$DIR/bar-functions/dwm_resources.sh"
# . "$DIR/bar-functions/dwm_spotify.sh"
#. "$DIR/bar-functions/dwm_transmission.sh"
. "$DIR/bar-functions/dwm_vpn.sh"
. "$DIR/bar-functions/dwm_weather.sh"
# . "$DIR/bar-functions/dwm_network_speed.sh"

parallelize2() {
	while true; do
		dwm_packages &
		sleep 60m
	done
}

parallelize() {
	while true; do
		dwm_weather &
		sleep 5m
	done
}

parallelize &
parallelize2 &

# Update dwm status bar every second
while true; do
	# Append results of each func one by one to the upperbar string
	upperbar=""
	# upperbar="$upperbar$(dwm_backlight)"
	if [ -d "/sys/class/power_supply/BAT0" ]; then
		upperbar="$upperbar$(dwm_battery)"
	fi

	upperbar="$upperbar$(dwm_date)"

	# Append results of each func one by one to the lowerbar string
	lowerbar=""
	lowerbar="$lowerbar$(dwm_resources)"
	# lowerbar="$lowerbar${__DWM_BAR_NETWORKMANAGER__}"
	lowerbar="$lowerbar$(dwm_vpn)"
	# lowerbar="$lowerbar$(dwm_network_speed)"; #dwm_network_speed_record
	lowerbar="$lowerbar${__DWM_BAR_WEATHER__}"
	lowerbar="$lowerbar${__DWM_BAR_PACKAGES__}"

	# Uncomment the line below to enable the lowerbar
	xsetroot -name "$upperbar;$lowerbar"
	sleep 1
done
