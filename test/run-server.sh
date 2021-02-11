#!/bin/bash
set -euxo pipefail

. "test/ovpn-common.sh"

if ! docker network ls --format '{{.Name}}' | grep $cname; then
    docker network create "$cnet"
fi

docker run -d --rm --name "$cname.ovpn-server" -i -p 4911:4911/tcp --network="$cnet" --cap-add=NET_ADMIN --device=/dev/net/tun "local/testenv-openvpn:latest" openvpn --config /etc/openvpn/ovpn-server.conf
