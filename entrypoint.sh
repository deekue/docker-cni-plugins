#!/bin/bash
#
# start CNI DHCP daemon

dhcpSock="/run/cni/dhcp.sock"

[[ -f "$dhcpSock" ]] && rm -f "${dhcpSock:?dhcpSock not set}"

exec /plugins/dhcp daemon "$@"
