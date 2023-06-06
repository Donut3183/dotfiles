#!/bin/sh

# A dwm_bar function to show VPN connections with OpenVPN or WireGuard (if any are active)
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: NetworkManager, NetworkManager-openvpn (for OpenVPN connections)

dwm_vpn () {
    # VPN=$(nmcli -a | grep 'VPN connection' | sed -e 's/\( VPN connection\)*$//g')
    VPN=$(mullvad status)
    
    if [ "$VPN" = "Disconnected" ]; then
        VPN=$(nmcli connection | grep 'wireguard' | sed 's/\s.*$//')
    fi

    if [ "$VPN" != "Disconnected" ]; then
        read -r CITY COUNTRY <<< $(echo "$VPN" | awk '{gsub(/,/, ""); print $(NF-1), $NF}')
        LOCATION="${CITY} - ${COUNTRY}"
        printf "%s" "$SEP1"
        if [ "$IDENTIFIER" = "unicode" ]; then
            printf " %s" "$LOCATION"
        else
            printf "VPN %s" "$VPN"
        fi
        printf "%s\n" "$SEP2"
    fi
}

dwm_vpn
