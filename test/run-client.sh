#!/bin/bash
set -euxo pipefail

. "test/ovpn-common.sh"

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <client1|client2>"
    exit 1
fi
client="$1"; shift

ovpn_server_ip=$(docker container inspect -f '{{(index .NetworkSettings.Networks "'$cnet'").IPAddress}}' "$cname.ovpn-server")

docker run -d --rm --name "$cname.ovpn-$client" -i --network="$cnet" --cap-add=NET_ADMIN --device=/dev/net/tun "local/testenv-openvpn:latest" openvpn --config "/etc/openvpn/ovpn-$client.conf" --remote "$ovpn_server_ip"
