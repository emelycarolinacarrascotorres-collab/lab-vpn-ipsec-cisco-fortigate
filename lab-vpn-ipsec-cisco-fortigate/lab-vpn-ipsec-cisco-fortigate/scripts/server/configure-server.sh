#!/bin/bash
# Configura la red del servidor web (Ubuntu) detrás del FortiGate.
# Uso:  sudo ./configure-server.sh
# Parámetros opcionales (variables de entorno): IFACE, IP_CIDR, GATEWAY
# Nota: la configuración no es persistente; para persistirla use netplan.
set -euo pipefail

IFACE="${IFACE:-eth0}"
IP_CIDR="${IP_CIDR:-10.25.97.2/28}"
GATEWAY="${GATEWAY:-10.25.97.1}"

ip addr flush dev "$IFACE"
ip addr add "$IP_CIDR" dev "$IFACE"
ip link set "$IFACE" up
ip route add default via "$GATEWAY"

echo "Configuración aplicada:"
ip -br addr show "$IFACE"
ip route show default
