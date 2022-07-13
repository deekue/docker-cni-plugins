#!/bin/sh
#
# start CNI DHCP daemon

dhcpSock="/run/cni/dhcp.sock"

[[ -f "$dhcpSock" ]] && rm -f "${dhcpSock:?dhcpSock not set}"

echo "Starting: /plugins/dhcp daemon $@"
exec /plugins/dhcp daemon "$@"
